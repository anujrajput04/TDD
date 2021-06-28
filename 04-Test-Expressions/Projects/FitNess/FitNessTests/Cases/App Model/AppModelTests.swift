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
    func givenGoalSet() {
        sut.dataModel.goal = 1000
    }
    
    func givenInProgress() {
        givenGoalSet()
        try! sut.start()
    }
    
    // MARK: - Lifecycle
    
    func testAppModel_whenInitialized_isInNotStartedState() {
        let initialState = sut.appState
        XCTAssertEqual(initialState, AppState.notStarted)
    }
    
    // MARK: - Start
    
    func testAppModel_whenStarted_isInInProgressState() {
        // given
        givenGoalSet()
        
        // when started
        try? sut.start()
        
        // then it is in inProgress
        let newState = sut.appState
        XCTAssertEqual(newState, AppState.inProgress)
    }
    
    func testModelWithNoGoal_whenStarted_throwsError() {
        XCTAssertThrowsError(try sut.start())
    }
    
    func testStart_withGoalSet_doesNotThrow() {
        // given
        givenGoalSet()
        
        // then
        XCTAssertNoThrow(try sut.start())
    }
    
    // MARK: - Restart
    
    func testAppModel_whenReset_isInNotStartedState() {
        // given
        givenInProgress()
        
        // when
        sut.restart()
        
        // then
        XCTAssertEqual(sut.appState, .notStarted)
    }
    
    func testDataModel_whenRestarted_goalIsNil() {
        // given
        givenInProgress()
        
        // when
        sut.restart()
        
        // then
        XCTAssertNil(sut.dataModel.goal)
    }
}
