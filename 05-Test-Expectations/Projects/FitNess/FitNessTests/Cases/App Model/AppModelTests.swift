import XCTest
@testable import FitNess

class AppModelTests: XCTestCase {
    
    var sut: AppModel!
    
    override func setUp() {
        super.setUp()
        sut = AppModel()
    }
    
    override func tearDown() {
        sut.stateChangedCallback = nil
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
    
    func givenCompleteReady() {
        sut.dataModel.setToComplete()
    }
    
    func givenCaughtReady() {
        sut.dataModel.setToCaught()
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
    
    // MARK: - Pause
    func testAppModel_whenPaused_isInPausedState() {
        // given
        givenInProgress()
        
        // when
        sut.pause()
        
        // then
        XCTAssertEqual(sut.appState, .paused)
    }
    
    // MARK: - Terminal States
    func testModel_whenCompleted_isInCompletedState() {
        // given
        givenCompleteReady()
        
        // when
        try? sut.setCompleted()
        
        // then
        XCTAssertEqual(sut.appState, .completed)
    }
    
    func testModelNotCompleteReady_whenCompleted_throwsError() {
        XCTAssertThrowsError(try sut.setCompleted())
    }
    
    func testModelCompleteReady_whenCompleted_doesNotThrow() {
        // given
        givenCompleteReady()
        
        // then
        XCTAssertNoThrow(try sut.setCompleted())
    }
    
    func testModel_whenCaught_isInCaughtState() {
        // given
        givenCaughtReady()
        
        // when started
        try? sut.setCaught()
        
        // then
        XCTAssertEqual(sut.appState, .caught)
    }
    
    func testModelNotCaughtReady_whenCaught_throwsError() {
        XCTAssertThrowsError(try sut.setCaught())
    }
    
    func testModelCaughtReady_whenCaught_doesNotThrow() {
        // given
        givenCaughtReady()
        
        // then
        XCTAssertNoThrow(try sut.setCaught())
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
    
    func testAppModel_whenRestarted_restartsDataModel() {
        // given
        givenInProgress()
        
        // when
        sut.restart()
        
        // then
        XCTAssertNil(sut.dataModel.goal)
    }
    
    // MARK: - State Changes
    
    func testAppModel_whenStateChanges_executesCallback() {
        // given
        givenInProgress()
        var observedState = AppState.notStarted
        
        // 1
        /// `expectation(description:)` is an `XCTestCase` method that creates an `XCTestExpectation` object. The `description` helps identify a failure in the test logs.
        let expected = expectation(description: "callback happened")
        sut.stateChangedCallback = { model in
            observedState = model.appState
            // 2
            /// `fulfill()` is called on the expectation to indicate it has been fulfilled - specifically, the callback has occured. Here `stateChangeCallback` will trigger on `sut` when a state change occurs.
            expected.fulfill()
        }
        
        // when
        sut.pause()
        
        // then
        // 3
        /// `wait(for:timeout:)` causes the test runner to pause until all expectations are fulfilled or the `timeout` time (in seconds) passes. The assertion will not be called until the wait completes
        wait(for: [expected], timeout: 1)
        XCTAssertEqual(observedState, .paused)
    }
}
