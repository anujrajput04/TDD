@testable import DogPatch
import XCTest

class DogPatchClientTests: XCTestCase {
    var baseURL: URL!
    var mockSession: MockURLSession!
    var sut: DogPatchClient!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        baseURL = URL(string: "https://example.com/api/v1/")!
        mockSession = MockURLSession()
        sut = DogPatchClient(baseURL: baseURL, session: mockSession)
    }

    override func tearDownWithError() throws {
        baseURL = nil
        mockSession = nil
        sut = nil
        try? super.tearDownWithError()
    }
    
    func test_init_sets_baseURL() {
        XCTAssertEqual(sut.baseURL, baseURL)
    }

    func test_init_sets_session() {
        XCTAssertEqual(sut.session, mockSession)
    }
    
    func test_getsDogs_callsExpectedURL() {
        // given
        let getDogsURL = URL(string: "dogs", relativeTo: baseURL)!
        
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
}

/// Create a `MockURLSession` as subclass of `URLSession` and override `dataTask(with url:, completionHandler:)` to return a `MockURLSessionDataTask`
class MockURLSession: URLSession {
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(completionHandler: completionHandler, url: url)
    }
}

/// Create  a `MockURLSessionDataTask` as a subclass of `URLSessionDataTask`, declare properties for `url` and `completionHandler` and set these values within its initializer.
class MockURLSessionDataTask: URLSessionDataTask {
    var completionHandler: (Data?, URLResponse?, Error?)  -> Void
    var url: URL
    
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void, url: URL) {
        self.completionHandler = completionHandler
        self.url = url
        super.init()
    }
    
    /// To ensure `MockURLSessionDataTask` never makes any real network requests, override `resume()` to do nothing
    var calledResume = false
    override func resume() {
        calledResume = true
    }
}
