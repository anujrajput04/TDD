import Foundation
@testable import FitNess

extension RootViewController {
    var stepController: StepCountController {
        return children.first { $0 is StepCountController }
        as! StepCountController
    }
    
    var alertController: AlertViewController {
        return children.first { $0 is AlertViewController }
        as! AlertViewController
    }
}
