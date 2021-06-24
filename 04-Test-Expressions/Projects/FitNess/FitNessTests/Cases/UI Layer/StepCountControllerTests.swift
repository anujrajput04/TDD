import XCTest
@testable import FitNess

class StepCountControllerTests: XCTestCase {
    
    var sut: StepCountController!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        sut = StepCountController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Given
    
    // MARK: - When
    
    fileprivate func whenStartStopPauseCalled() {
        sut.startStopPause(nil)
    }
    
    // MARK: - Initial State
    
    func testController_whenCreated_buttonLabelIsStart() {
        // given
        sut.viewDidLoad()
        
        let text = sut.startButton.title(for: .normal)
        XCTAssertEqual(text, AppState.notStarted.nextStateButtonLabel)
    }
    
    // MARK: - Goal
    
    
    // MARK: - In Progress
    
    func testController_whenStartTapped_appIsInProgress() {
        whenStartStopPauseCalled()
        
        // then
        let state = AppModel.instance.appState
        XCTAssertEqual(state, AppState.inProgress)
    }
    
    func testController_whenStartTapped_buttonLabelIsPause() {
        whenStartStopPauseCalled()
        
        // then
        let text = sut.startButton.title(for: .normal)
        XCTAssertEqual(text, AppState.inProgress.nextStateButtonLabel)
    }
    
    // MARK: - Chase View
}
