import XCTest
@testable import FitNess

class DataModelTests: XCTestCase {
    
    var sut: DataModel!
    
    override func setUp() {
        super.setUp()
        sut = DataModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Given
    func givenSomeProgress() {
        sut.goal = 1000
        sut.distance = 10
        sut.steps = 100
        sut.nessie.distance = 50
    }
    
    // MARK: - Lifecycle
    func testModel_whenRestarted_goalIsUnset() {
        // given
        givenSomeProgress()
        
        // when
        sut.restart()
        
        // then
        XCTAssertNil(sut.goal)
    }
    
    func testModel_whenRestarted_stepsAreCleared() {
        // given
        givenSomeProgress()
        
        // when
        sut.restart()
        
        // then
        XCTAssertLessThanOrEqual(sut.steps, 0)
    }
    
    func testModel_whenRestarted_distanceIsCleared() {
        // given
        givenSomeProgress()
        
        // when
        sut.restart()
        
        // then
        XCTAssertEqual(sut.distance, 0)
    }
    
    func testModel_whenRestarted_nessieIsReset() {
        // given
        givenSomeProgress()
        
        // when
        sut.restart()
        
        // then
        XCTAssertEqual(sut.nessie.distance, 0)
    }
    
    // MARK: - Goal
    func testModel_whenStarted_goalIsNotReached() {
        XCTAssertFalse(sut.goalReached,
                       "goalReached should be false when the model is created")
    }
    
    func testModel_whenStepsReachGoal_goalIsReached() {
        // given
        sut.goal = 1000
        
        // when
        sut.steps = 1000
        
        // then
        XCTAssertTrue(sut.goalReached)
    }
    
    func testGoal_whenUserCaught_cannotBeReached() {
        //given goal should be reached
        sut.goal = 1000
        sut.steps = 1000
        
        // when caught by nessie
        sut.distance = 100
        sut.nessie.distance = 100
        
        // then
        XCTAssertFalse(sut.goalReached)
    }
    
    // MARK: - Nessie
    func testModel_whenStarted_userIsNotCaught() {
        XCTAssertFalse(sut.caught)
    }
    
    func testModel_whenUserAheadOfNessie_isNotCaught() {
        // given
        sut.distance = 1000
        sut.nessie.distance = 100
        
        // then
        XCTAssertFalse(sut.caught)
    }
    
    func testModel_whenNessieAheadofUser_isCaught() {
        // given
        sut.nessie.distance = 1000
        sut.distance = 100
        
        // then
        XCTAssertTrue(sut.caught)
    }
}
