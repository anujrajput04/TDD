import XCTest
import CoreMotion
@testable import FitNess

class PedometerTests: XCTestCase {
    
    var sut: CMPedometer!
    
    override func setUp() {
        super.setUp()
        sut = CMPedometer()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
