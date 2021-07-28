import Foundation

protocol Pedometer {
    var pedometerAvailable: Bool { get }
    var permissionDeclined: Bool { get }
    func start(completion: @escaping (Error?) -> Void)
}
