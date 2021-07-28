import Foundation

protocol Pedometer {
    var pedometerAvailable: Bool { get }
    func start()
}
