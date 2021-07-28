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
    let pedometer: Pedometer
    
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
        pedometer.start()
    }
}
