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
    
    func testCMPedometer_whenQueries_loadsHistoricalData() {
        // given
        var error: Error?
        var data: CMPedometerData?
        let exp = expectation(description: "pedometer query returns")
        
        // when
        let now = Date()
        let then = now.addingTimeInterval(-1000)
        sut.queryPedometerData(from: then, to: now) { pedometerData, pedometerError in
            error = pedometerError
            data = pedometerData
            exp.fulfill()
        }
        
        // then
        wait(for: [exp], timeout: 1)
        XCTAssertNil(error)
        XCTAssertNotNil(data)
        if let steps = data?.numberOfSteps {
            XCTAssertGreaterThan(steps.intValue, 0)
        } else {
            XCTFail("no step data")
        }
    }
}
