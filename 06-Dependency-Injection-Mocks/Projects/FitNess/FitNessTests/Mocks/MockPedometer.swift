import CoreMotion
@testable import FitNess

class MockPedometer: Pedometer {
    private(set) var started: Bool = false
    var pedometerAvailable: Bool = true
    var permissionDeclined: Bool = false
    var error: Error?
    
    func start(completion: @escaping (Error?) -> Void) {
        started = true
        DispatchQueue.global(qos: .default).async {
            completion(self.error)
        }
    }
    
    static let notAuthorizedError = NSError(domain: CMErrorDomain, code: Int(CMErrorMotionActivityNotAuthorized.rawValue), userInfo: nil)
}
