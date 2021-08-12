@testable import DogPatch
import XCTest

class DogPatchClientTests: XCTestCase {
    var baseURL: URL!
    var session: URLSession!
    var sut: DogPatchClient!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        baseURL = URL(string: "https://example.com/api/v1/")!
        session = URLSession.shared
        sut = DogPatchClient(baseURL: baseURL, session: session)
    }

    override func tearDownWithError() throws {
        baseURL = nil
        session = nil
        sut = nil
        try? super.tearDownWithError()
    }
    
    func test_init_sets_baseURL() {
        XCTAssertEqual(sut.baseURL, baseURL)
    }

    func test_init_sets_session() {
        XCTAssertEqual(sut.session, session)
    }
}
