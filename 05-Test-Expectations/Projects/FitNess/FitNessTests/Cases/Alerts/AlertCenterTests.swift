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
}
