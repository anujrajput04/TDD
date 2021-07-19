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
        AlertCenter.instance.clearAlerts()
        super.tearDown()
    }
    
    // MARK: - Given
    func givenSomeProgress() {
        sut.goal = 1000
        sut.distance = 10
        sut.steps = 100
        sut.nessie.distance = 50
    }
    
    func givenExpectationForNotification(alert: Alert) -> XCTestExpectation {
        let exp = XCTNSNotificationExpectation(name: AlertNotification.name, object: AlertCenter.instance, notificationCenter: AlertCenter.instance.notificationCenter)
        exp.handler = { notification -> Bool in
            notification.alert == alert
        }
        exp.expectedFulfillmentCount = 1
        exp.assertForOverFulfill = true
        return exp
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
    
    // MARK: - Alerts
    
    func testWhenStepsHit25Percent_milestoneNotificationGenerated() {
        // given
        sut.goal = 400
        let exp = givenExpectationForNotification(alert: .milestone25Percent)
        
        // when
        sut.steps = 100
        
        // then
        wait(for: [exp], timeout: 1)
    }
    
    func testWhenStepsHit50Percent_milestoneNotificationGenerated() {
        // given
        sut.goal = 400
        let exp = givenExpectationForNotification(alert: .milestone50Percent)
        
        // when
        sut.steps = 200
        
        // then
        wait(for: [exp], timeout: 1)
    }
    
    func testWhenStepsHit75Percent_milestoneNotificationGenerated() {
        // given
        sut.goal = 400
        let exp = givenExpectationForNotification(alert: .milestone75Percent)
        
        // when
        sut.steps = 300
        
        // then
        wait(for: [exp], timeout: 1)
    }
    
    func testWhenStepsHit100Percent_milestoneNotificationGenerated() {
        // given
        sut.goal = 400
        let exp = givenExpectationForNotification(alert: .goalComplete)
        
        // when
        sut.steps = 400
        
        // then
        wait(for: [exp], timeout: 1)
    }
    
    func testWhenGoalReached_allMilestoneNotificationsSent() {
        // given
        sut.goal = 400
        let expectations = [
            givenExpectationForNotification(alert: .milestone25Percent),
            givenExpectationForNotification(alert: .milestone50Percent),
            givenExpectationForNotification(alert: .milestone75Percent),
            givenExpectationForNotification(alert: .goalComplete)
        ]
        
        // when
        sut.steps = 400
        
        // then
        wait(for: expectations, timeout: 1, enforceOrder: true)
    }
    
    func testWhenStepsIncreased_onlyOneMilestoneNotificationSent() {
        // given
        /// setup up a sequence of milestone alert expectations
        sut.goal = 10
        let expectations = [
            givenExpectationForNotification(alert: .milestone25Percent),
            givenExpectationForNotification(alert: .milestone50Percent),
            givenExpectationForNotification(alert: .milestone75Percent),
            givenExpectationForNotification(alert: .goalComplete)
        ]
        
        // clear out the alerts to simulate user interaction
        /// observer watches for alerts and clears them from `AlertCenter`. This ensures that repeated notifications don't get ignored because they haven't yet been dismissed by the user.
        let alertObserver = AlertCenter.instance.notificationCenter
            .addObserver(
                forName: AlertNotification.name,
                object: nil,
                queue: .main) { notification in
                if let alert = notification.alert {
                    AlertCenter.instance.clear(alert: alert)
                }
            }
        
        // when
        /// increment the `steps` to generate the alerts by crossing a series of milestones individually. Using `sleep` or equivalent in tests should only be done sparingly as this drastically increases the test time. It's necessary here to give time for the notifications to post and be cleared
        for step in 1...10 {
            self.sut.steps = step
            sleep(1)
        }
        
        // then
        /// use `wait` to test that the expectations are fulfilled as expected. Ath the end of the test, remove `alertObserver` to prevent it from impacting other tests.
        wait(for: expectations, timeout: 20, enforceOrder: true)
        AlertCenter.instance.notificationCenter.removeObserver(alertObserver)
    }
}
