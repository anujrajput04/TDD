@testable import FitNess

class ChaseViewPartialMock: ChaseView {
    var updateStateCalled = false
    var lastRuner: Double?
    var lastNessie: Double?
    
    override func updateState(runner: Double, nessie: Double) {
        updateStateCalled = true
        lastRuner = runner
        lastNessie = nessie
        super.updateState(runner: runner, nessie: nessie)
    }
}
