import Foundation

class DataModel {
    var goalReached: Bool {
        if let goal = goal,
           steps >= goal {
            return true
        }
        return false
    }
    var goal: Int?
    var steps: Int = 0
}
