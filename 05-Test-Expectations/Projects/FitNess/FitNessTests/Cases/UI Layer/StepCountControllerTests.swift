import XCTest
@testable import FitNess

class StepCountControllerTests: XCTestCase {
    
    var sut: StepCountController!
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        let rootController = loadRootViewController()
        sut = rootController.stepController
    }
    
    override func tearDown() {
        AppModel.instance.restart()
        sut.updateUI()
        super.tearDown()
    }
    
    // MARK: - Given
    func givenGoalSet() {
        AppModel.instance.dataModel.goal = 1000
    }
    
    func givenInProgress() {
        givenGoalSet()
        sut.startStopPause(nil)
        // inProgress ensured by testController_whenStartTapped_appIsInProgress
    }
    
    func givenPaused() {
        givenInProgress()
        sut.startStopPause(nil)
        // paused ensured by testControllerInProgress_whenPauseTapped_appIsPaused
    }
    
    func givenCaught() {
        AppModel.instance.setToCaught()
    }
    
    func givenCompleted() {
        AppModel.instance.setToComplete()
    }
    
    // MARK: - When
    fileprivate func whenStartStopPauseCalled() {
        sut.startStopPause(nil)
    }
    
    // MARK: - Initial State
    func testController_whenCreated_buttonLabelIsStart() {
        // when loaded, then
        let text = sut.startButton.title(for: .normal)
        XCTAssertEqual(text, AppState.notStarted.nextStateButtonLabel)
    }
    
    // MARK: - Goal
    func testDataModel_whenGoalUpdate_updatesToNewGoal() {
        // when
        sut.updateGoal(newGoal: 50)
        
        // then
        XCTAssertEqual(AppModel.instance.dataModel.goal, 50)
    }
    
    // MARK: - In Progress
    func testController_whenStartTapped_appIsInProgress() {
        // given
        givenGoalSet()
        
        // when
        whenStartStopPauseCalled()
        
        // then
        let state = AppModel.instance.appState
        XCTAssertEqual(state, AppState.inProgress)
    }
    
    // MARK: - Pause
    func testController_whenStartTapped_buttonLabelIsPause() {
        // given
        givenGoalSet()
        
        // when
        whenStartStopPauseCalled()
        
        // then
        let text = sut.startButton.title(for: .normal)
        XCTAssertEqual(text, AppState.inProgress.nextStateButtonLabel)
    }
    
    func testControllerInProgress_whenPauseTapped_appIsPaused() {
        // given
        givenInProgress()
        
        // when
        whenStartStopPauseCalled()
        
        // then
        XCTAssertEqual(AppModel.instance.appState, .paused)
    }
    
    func testControllerInProgress_whenPauseTapped_buttonLabelIsStart() {
        // given
        givenPaused()
        
        // then
        let text = sut.startButton.title(for: .normal)
        XCTAssertEqual(text, AppState.paused.nextStateButtonLabel)
    }
    
    func testControllerPaused_whenStartTapped_appIsInProgress() {
        // given
        givenPaused()
        
        // when
        whenStartStopPauseCalled()
        
        // then
        XCTAssertEqual(AppModel.instance.appState, .inProgress)
    }
    
    // MARK: - Terminal States
    func testControllerCompleted_whenRestartTapped_appIsNotStarted() {
        // given
        givenCompleted()
        
        // when
        whenStartStopPauseCalled()
        
        // then
        XCTAssertEqual(AppModel.instance.appState, .notStarted)
    }
    
    func testControllerCaught_whenRestartTapped_appIsNotStarted() {
        // given
        givenCompleted()
        
        // when
        whenStartStopPauseCalled()
        
        // then
        XCTAssertEqual(AppModel.instance.appState, .notStarted)
    }
    
    // MARK: - Chase View
    func testChaseView_whenLoaded_isNotStarted() {
        // when loaded, then
        let chaseView = sut.chaseView
        XCTAssertEqual(chaseView?.state, AppState.notStarted)
    }
    
    func testChaseView_whenInProgress_viewIsInProgress() {
        // given
        givenInProgress()
        
        // then
        let chaseView = sut.chaseView
        XCTAssertEqual(chaseView?.state, AppState.inProgress)
    }
}
