@testable import DogPatch
import XCTest

class DogPatchClientTests: XCTestCase {
    var baseURL: URL!
    var mockSession: MockURLSession!
    var sut: DogPatchClient!
    var getDogsURL: URL {
        URL(string: "dogs", relativeTo: baseURL)!
    }
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        baseURL = URL(string: "https://example.com/api/v1/")!
        mockSession = MockURLSession()
        sut = DogPatchClient(baseURL: baseURL, session: mockSession, responseQueue: nil)
    }

    override func tearDownWithError() throws {
        baseURL = nil
        mockSession = nil
        sut = nil
        try? super.tearDownWithError()
    }
    
    func whenGetDogs(data: Data? = nil,
                     statusCode: Int = 200,
                     error: Error? = nil) ->
    (calledCompletion: Bool, dogs: [Dog]?, error: Error?) {
        
        let response = HTTPURLResponse(url: getDogsURL, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        
        var calledCompletion = false
        var receivedDogs: [Dog]? = nil
        var receivedError: Error? = nil
        
        let mockTask = sut.getDogs { (dogs, error) in
            calledCompletion = true
            receivedDogs = dogs
            receivedError = error as NSError?
        } as! MockURLSessionDataTask
        
        mockTask.completionHandler(data, response, error)
        return (calledCompletion, receivedDogs, receivedError)
    }
    
    func test_init_sets_baseURL() {
        XCTAssertEqual(sut.baseURL, baseURL)
    }

    func test_init_sets_session() {
        XCTAssertEqual(sut.session, mockSession)
    }
    
    func test_init_sets_responseQueue() {
        // given
        let responseQueue = DispatchQueue.main
        
        // when
        sut = DogPatchClient(baseURL: baseURL,
                             session: mockSession,
                             responseQueue: responseQueue)
        
        // then
        XCTAssertEqual(sut.responseQueue, responseQueue)
    }
    
    func test_getsDogs_callsExpectedURL() {
        // when
        let mockTask = sut.getDogs() { _, _ in } as! MockURLSessionDataTask
        
        // then
        XCTAssertEqual(mockTask.url, getDogsURL)
    }
    
    func test_getsDogs_callsResumeOnTask() {
        // when
        let mockTask = sut.getDogs { _, _ in } as! MockURLSessionDataTask
        
        // then
        XCTAssertTrue(mockTask.calledResume)
    }
    
    func test_getDogs_givenResponseStatusCode500_callsCompletion() {
        // when
        let result = whenGetDogs(statusCode: 500)
        
        // then
        XCTAssertTrue(result.calledCompletion)
        XCTAssertNil(result.dogs)
        XCTAssertNil(result.error)
    }
     
    func test_getDogs_givenError_callsCompletionWithError() throws {
        // given
        let expectedError = NSError(domain: "com.DogPatchTests",
                                    code: 42)
        
        //when
        let result = whenGetDogs(error: expectedError)
        
        // then
        XCTAssertTrue(result.calledCompletion)
        XCTAssertNil(result.dogs)
        
        let actualError = try XCTUnwrap(result.error as NSError?)
        XCTAssertEqual(actualError, expectedError)  
    }
    
    func test_getDogs_givenValidJSON_callsCompletionWithDogs() throws {
        // given
        let data = try Data.fromJSON(fileName: "GET_Dogs_Response")
        
        let decoder = JSONDecoder()
        let dogs = try decoder.decode([Dog].self, from: data)
        
        // when
        let result = whenGetDogs(data: data)
        
        // then
        XCTAssertTrue(result.calledCompletion)
        XCTAssertEqual(result.dogs, dogs)
        XCTAssertNil(result.error)
    }
    
    func test_getDogs_givenInvalidJSON_callsCompletionWithError() throws {
        // given
        let data = try Data.fromJSON(fileName: "GET_Dogs_MissingValuesResponse")
        
        var expectedError: NSError!
        let decoder = JSONDecoder()
        
        do {
            _ = try decoder.decode([Dog].self, from: data)
        } catch {
            expectedError = error as NSError
        }
        
        // when
        let result = whenGetDogs(data: data)
        
        // then
        XCTAssertTrue(result.calledCompletion)
        XCTAssertNil(result.dogs)
        
        let actualError = try XCTUnwrap(result.error as NSError?)
        XCTAssertEqual(actualError.domain, expectedError.domain)
        XCTAssertEqual(actualError.code, expectedError.code)
    }
}

/// Create a `MockURLSession` as subclass of `URLSession` and override `dataTask(with url:, completionHandler:)` to return a `MockURLSessionDataTask`
class MockURLSession: URLSession {
    
    var queue: DispatchQueue? = nil
    
    func givenDispatchQueue() {
        queue = DispatchQueue(label: "com.DogPatchTests.MockSession")
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(completionHandler: completionHandler, url: url, queue: queue)
    }
}

/// Create  a `MockURLSessionDataTask` as a subclass of `URLSessionDataTask`, declare properties for `url` and `completionHandler` and set these values within its initializer.
class MockURLSessionDataTask: URLSessionDataTask {
    var completionHandler: (Data?, URLResponse?, Error?)  -> Void
    var url: URL
    
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void,
         url: URL,
         queue: DispatchQueue?) {
        if let queue = queue {
            self.completionHandler = { data, response, error in
                queue.async() {
                    completionHandler(data, response, error)
                }
            }
        } else {
            self.completionHandler = completionHandler
        }
        
        self.url = url
        super.init()
    }
    
    /// To ensure `MockURLSessionDataTask` never makes any real network requests, override `resume()` to do nothing
    var calledResume = false
    override func resume() {
        calledResume = true
    }
}
