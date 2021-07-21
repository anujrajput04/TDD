import Foundation
import XCTest
@testable import FitNess

extension Notification {
    var alert: Alert? {
        return userInfo?[AlertNotification.Keys.alert] as? Alert
    }
}

func alertHandler(_ alert: Alert) -> XCTNSNotificationExpectation.Handler {
    return { notification -> Bool in
        return notification.alert == alert
    }
}
