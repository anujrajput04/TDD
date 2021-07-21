import CoreMotion

extension CMPedometer: Pedometer {
    func start() {
        startEventUpdates { event, error in
            // do nothing here for now
        }
    }
}
