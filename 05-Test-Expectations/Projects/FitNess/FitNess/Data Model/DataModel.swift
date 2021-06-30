import Foundation

class DataModel {
    
    // MARK: - Goal Calculation
    var goal: Int?
    var steps: Int = 0
    
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
}
