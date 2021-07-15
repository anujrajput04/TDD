@testable import FitNess
import Foundation

extension Notification {
    var alert: Alert? {
        userInfo?[AlertNotification.Keys.alert] as? Alert
    }
}
