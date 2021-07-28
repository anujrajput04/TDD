import Foundation
import CoreMotion

class AppModel {
    
    static let instance = AppModel()
    
    let dataModel = DataModel()
    
    private(set) var appState: AppState = .notStarted {
        didSet {
            stateChangedCallback?(self)
        }
    }
    
    var stateChangedCallback: ((AppModel) -> ())?
    var pedometer: Pedometer
    
    init(pedometer: Pedometer = CMPedometer()) {
        self.pedometer = pedometer
    }
    
    // MARK: - App Lifecycle
    func start() throws {
        guard dataModel.goal != nil else {
            throw AppError.goalNotSet
        }
        
        guard pedometer.pedometerAvailable else {
            AlertCenter.instance.postAlert(alert: .noPedometer)
            return
        }
        
        guard !pedometer.permissionDeclined else {
            AlertCenter.instance.postAlert(alert: .notAuthorized)
            return
        }
        
        appState = .inProgress
        startPedometer()
    }
    
    func pause() {
        appState = .paused
    }
    
    func restart() {
        appState = .notStarted
        dataModel.restart()
    }
    
    func setCaught() throws {
        guard dataModel.caught else {
            throw AppError.invalidState
        }
        
        appState = .caught
    }
    
    func setCompleted() throws {
        guard dataModel.goalReached else {
            throw AppError.invalidState
        }
        
        appState = .completed
    }
}

// MARK: - Pedometer
extension AppModel {
    func startPedometer() {
        pedometer.start { error in
            if let error = error {
                let alert = error.is(CMErrorMotionActivityNotAuthorized) ? .notAuthorized : Alert(error.localizedDescription)
                AlertCenter.instance.postAlert(alert: alert)
            }
        }
    }
}
