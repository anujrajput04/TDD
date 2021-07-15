import Foundation

class DataModel {
    
    // MARK: - Goal Calculation
    var goal: Int?
    var steps: Int = 0 {
        didSet {
            updateForSteps()
        }
    }
    
    var goalReached: Bool {
        if let goal = goal,
           steps >= goal, !caught {
            return true
        }
        return false
    }
    
    // MARK: - Nessie
    let nessie = Nessie()
    var distance: Double = 0
    
    var caught: Bool {
        return distance > 0 && nessie.distance >= distance
    }
    
    // MARK: - Lifecycle
    func restart() {
        goal = nil
        steps = 0
        distance = 0
        nessie.distance = 0
    }
    
    // MARK: - Updates due to distance
    func updateForSteps() {
        guard let goal = goal else { return }
        if Double(steps) >= Double(goal) * 0.25 {
            AlertCenter.instance.postAlert(alert: Alert.milestone25Percent)
        }
        if Double(steps) >= Double(goal) * 0.50 {
            AlertCenter.instance.postAlert(alert: Alert.milestone50Percent)
        }
        if Double(steps) >= Double(goal) * 0.75 {
            AlertCenter.instance.postAlert(alert: Alert.milestone75Percent)
        }
        if Double(steps) >= Double(goal) * 1.0 {
            AlertCenter.instance.postAlert(alert: Alert.goalComplete)
        }
    }
}
