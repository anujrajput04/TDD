import Foundation

class DataModel {
    
    // MARK: - Alerts
    var sentAlerts: [Alert] = []
    
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
        sentAlerts.removeAll()
    }
    
    // MARK: - Updates due to distance
    private func checkThreshold(percent: Double, alert: Alert) {
        guard !sentAlerts.contains(alert), let goal = goal else {
            return
        }
        
        if Double(steps) >= Double(goal) * percent {
            AlertCenter.instance.postAlert(alert: alert)
            sentAlerts.append(alert)
        }
    }
    
    func updateForSteps() {
        checkThreshold(percent: 0.25, alert: .milestone25Percent)
        checkThreshold(percent: 0.50, alert: .milestone50Percent)
        checkThreshold(percent: 0.75, alert: .milestone75Percent)
        checkThreshold(percent: 1.00, alert: .goalComplete)
    }
}
