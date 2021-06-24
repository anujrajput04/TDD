import Foundation

class AppModel {
    
    static let instance = AppModel()
    
    private(set) var appState: AppState = .notStarted
    
    func start() {
        appState = .inProgress
    }
}
