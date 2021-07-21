import UIKit

class AlertViewController: UIViewController {
    
    struct ViewValues {
        let alertText: String?
        let justOneAlert: Bool
        let topAlertInset: CGFloat
        let topColor: UIColor?
        let bottomColor: UIColor?
    }
    
    @IBOutlet weak var mainAlertView: UIView!
    @IBOutlet weak var secondaryAlertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var mainBottom: NSLayoutConstraint!
    @IBOutlet weak var mainTrailing: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainAlertView.layer.borderWidth = 1
        secondaryAlertView.layer.borderWidth = 1
        
        AlertCenter.listenForAlerts { center in
            self.updateForAlert()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateForAlert()
    }
    
    func calculateViewValues() -> ViewValues {
        let justOneAlert = AlertCenter.instance.alertCount == 1
        let mainInset: CGFloat = justOneAlert ? 0 : 8
        let topColor = AlertCenter.instance.topAlert?.severity.color
        let alertText = AlertCenter.instance.topAlert?.text
        let bottomColor = AlertCenter.instance.nextUp?.severity.color
        
        return ViewValues(alertText: alertText, justOneAlert: justOneAlert, topAlertInset: mainInset, topColor: topColor, bottomColor: bottomColor)
    }
    
    func updateForAlert() {
        guard AlertCenter.instance.alertCount > 0 else {
            (parent as? RootViewController)?.hideShowAlert()
            return
        }
        let values = calculateViewValues()
        alertLabel.text = values.alertText
        mainAlertView.backgroundColor = values.topColor
        mainBottom.constant = values.topAlertInset
        mainTrailing.constant = values.topAlertInset
        
        secondaryAlertView.isHidden = values.justOneAlert
        secondaryAlertView.backgroundColor = values.bottomColor
    }
    
    @IBAction func closeAlert(_ sender: Any) {
        if let top = AlertCenter.instance.topAlert {
            AlertCenter.instance.clear(alert: top)
            updateForAlert()
        }
    }
}

extension Alert.Severity {
    var color: UIColor {
        switch self {
        case .bad:
            return UIColor(named: "BadAlertColor")!
        case .good:
            return UIColor(named: "GoodAlertColor")!
        }
    }
}
