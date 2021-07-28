import CoreMotion

extension CMPedometer: Pedometer {
    var pedometerAvailable: Bool {
        CMPedometer.isStepCountingAvailable() &&
        CMPedometer.isDistanceAvailable() &&
        CMPedometer.authorizationStatus() != .restricted
    }
    
    var permissionDeclined: Bool {
        CMPedometer.authorizationStatus() == .denied
    }
    
    func start(completion: @escaping (Error?) -> Void) {
        startEventUpdates { event, error in
            completion(error)
        }
    }
}
