import CoreMotion
@testable import FitNess

class MockPedometer: Pedometer {
    private(set) var started: Bool = false
    
    func start() {
        started = true
    }
}
