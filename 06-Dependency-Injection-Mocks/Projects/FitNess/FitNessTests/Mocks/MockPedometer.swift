import CoreMotion
@testable import FitNess

class MockPedometer: Pedometer {
    private(set) var started: Bool = false
    var pedometerAvailable: Bool = true
    var permissionDeclined: Bool = false
    
    func start() {
        started = true
    }
}
