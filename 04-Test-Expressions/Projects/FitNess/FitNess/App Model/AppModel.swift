import Foundation

class AppModel {
    
    static let instance = AppModel()
    let dataModel = DataModel()
    
    private(set) var appState: AppState = .notStarted
    
    func start() throws {
        guard dataModel.goal != nil else {
            throw AppError.goalNotSet
        }
        
        appState = .inProgress
    }
    
    func restart() {
        appState = .notStarted
    }
}
