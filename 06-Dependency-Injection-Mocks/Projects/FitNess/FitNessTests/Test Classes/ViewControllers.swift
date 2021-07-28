import Foundation
import UIKit
@testable import FitNess

func loadRootViewController() -> RootViewController {
    AppModel.instance.pedometer = MockPedometer()
    let window = UIApplication.shared.windows[0]
    return window.rootViewController as! RootViewController
}
