import XCTest
@testable import FitNess

class RootViewControllerTests: XCTestCase {

    var sut: RootViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = loadRootViewController()
        sut.reset()
    }

    override func tearDownWithError() throws {
        sut = nil
        AlertCenter.instance.clearAlerts()
        try super.tearDownWithError()
    }
    
    // MARK: - Alert Container
    
    func testWhenLoaded_noAlertsAreShown() {
        XCTAssertTrue(sut.alertContainer.isHidden)
    }
    
    func testWhenAlertsPosted_alertContainerIsShown() {
        // given
        let exp = expectation(forNotification: AlertNotification.name, object: nil, handler: nil)
        let alert = Alert("show thecontainer")
        
        // when
        AlertCenter.instance.postAlert(alert: alert)
        
        // then
        
        wait(for: [exp], timeout: 1)
        XCTAssertFalse(sut.alertContainer.isHidden)
    }
}
