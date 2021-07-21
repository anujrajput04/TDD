import UIKit

@IBDesignable class ChaseView: UIView {
    
    let nessieView = UIImageView()
    let runnerView = UIImageView()
    
    private var runnerComplete: CGFloat = 0
    private var nessieComplete: CGFloat = 0
    
    var state: AppState = .notStarted {
        didSet {
            nessieView.image = state.nessieImage
            runnerView.image = state.runnerImage
        }
    }
    
    private func commonSetup() {
        addSubview(nessieView)
        addSubview(runnerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        let bundle = Bundle(for: ChaseView.self)
        nessieView.image = UIImage(named: "Nessie", in: bundle, compatibleWith: nil)
        runnerView.image = UIImage(named: "Runner", in: bundle, compatibleWith: nil)
    }
    
    override func layoutSubviews() {
        let runnerX = runnerComplete
        let nessieX = nessieComplete * runnerX
        
        
        let iconSize: CGFloat = 100
        let width = frame.width - iconSize
        let y = max(0, frame.height - iconSize)
        let nessieFrame = CGRect(x: min(max(nessieX * width, 0), width), y: y, width: iconSize, height: iconSize)
        let runnerFrame = CGRect(x: min(max(runnerX * width, 0), width), y: y, width: iconSize, height: iconSize)
        
        nessieView.frame = nessieFrame.integral
        runnerView.frame = runnerFrame.integral
    }
    
    func updateState(runner: Double, nessie: Double) {
        runnerComplete = CGFloat(runner)
        nessieComplete = CGFloat(nessie)
        setNeedsLayout()
    }
}

extension AppState {
    var nessieImage: UIImage {
        let imageName: String
        switch self {
        case .notStarted:
            imageName = "NessieSleeping"
        case .inProgress:
            imageName = "Nessie"
        case .paused:
            imageName = "NessieSleeping"
        case .completed:
            imageName = "NessieLost"
        case .caught:
            imageName = "NessieWon"
        }
        return UIImage(named: imageName)!
    }
    
    var runnerImage: UIImage {
        let imageName: String
        switch self {
        case .notStarted:
            imageName = "RunnerPaused"
        case .inProgress:
            imageName = "Runner"
        case .paused:
            imageName = "RunnerPaused"
        case .completed:
            imageName = "RunnerWon"
        case .caught:
            imageName = "RunnerEaten"
        }
        return UIImage(named: imageName)!
    }
}
