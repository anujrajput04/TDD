import UIKit
@testable import FitNess

func loadRootViewController() -> RootViewController {
    let window = UIApplication.shared.windows[0]
    return window.rootViewController as! RootViewController
}
