import UIKit

class RootViewController: UIViewController {
    @IBOutlet weak var alertHeight: NSLayoutConstraint!
    @IBOutlet weak var alertContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }
    
    // resets the view to the didLoad state
    func reset() {
        alertContainer.isHidden = true
    }
}
