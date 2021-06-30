import Foundation

class AlertCenter {
    static var instance = AlertCenter()
    
    init(center: NotificationCenter = .default) {
        self.notificationCenter = center
    }
    
    // MARK: - Notifications
    let notificationCenter: NotificationCenter
    
    func postAlert(alert: Alert) {
        //stub implementation
    }
}

// MARK: - Class Helpers
extension AlertCenter {
    
}

