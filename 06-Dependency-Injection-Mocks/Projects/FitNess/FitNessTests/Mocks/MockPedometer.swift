import CoreMotion
@testable import FitNess

class MockPedometer: Pedometer {
    private(set) var started: Bool = false
    var pedometerAvailable: Bool = true
    
    func start() {
        started = true
    }
}
