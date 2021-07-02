import XCTest
@testable import FitNess

class AlertCenterTests: XCTestCase {
    
    var sut: AlertCenter!
    
    override func setUp() {
        super.setUp()
        sut = AlertCenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testPostOne_generatesANotification() {
        // given
        let expectation = expectation(forNotification: AlertNotification.name, object: sut, handler: nil)
        let alert = Alert("this is an alert")
        
        // when
        sut.postAlert(alert: alert)
        
        // then
        wait(for: [expectation], timeout: 1)
    }
    
    func testPostingTwoAlerts_generatesTwoNotifications() {
        // given
        let expectation = expectation(forNotification: AlertNotification.name, object: sut, handler: nil)
        expectation.expectedFulfillmentCount = 2
        let alert1 = Alert("this is the first alert")
        let alert2 = Alert("this is the second alert")
        
        // when
        sut.postAlert(alert: alert1)
        sut.postAlert(alert: alert2)
        
        // then
        wait(for: [expectation], timeout: 1)
    }
}
