import Foundation

internal class AppModel {
    
    static let instance = AppModel()
    
    public var appState: AppState = .notStarted
    
    public init() {}
    
    public func start() {
        appState = .inProgress
    }
}
