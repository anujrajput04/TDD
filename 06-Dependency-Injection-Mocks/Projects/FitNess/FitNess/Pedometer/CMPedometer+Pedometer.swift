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
    
    func start() {
        startEventUpdates { event, error in
            // do nothing here for now
        }
    }
}
