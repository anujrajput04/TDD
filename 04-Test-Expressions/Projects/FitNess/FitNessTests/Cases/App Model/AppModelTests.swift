import XCTest
@testable import FitNess

class AppModelTests: XCTestCase {
    
    var sut: AppModel!
    
    override func setUp() {
        super.setUp()
        sut = AppModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Given
    
    // MARK: - Lifecycle
    
    func testAppModel_whenInitialized_isInNotStartedState() {
        let initialState = sut.appState
        XCTAssertEqual(initialState, AppState.notStarted)
    }
    
    // MARK: - Start
    
    func testAppModel_whenStarted_isInInProgressState() {
        // when started
        sut.start()
        
        // then it is in inProgress
        let newState = sut.appState
        XCTAssertEqual(newState, AppState.inProgress)
    }
}
