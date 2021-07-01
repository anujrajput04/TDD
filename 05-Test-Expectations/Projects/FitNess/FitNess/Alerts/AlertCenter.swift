import Foundation

class AlertCenter {
    static var instance = AlertCenter()
    
    init(center: NotificationCenter = .default) {
        self.notificationCenter = center
    }
    
    // MARK: - Notifications
    let notificationCenter: NotificationCenter
    
    func postAlert(alert: Alert) {
        let notification = Notification(name: AlertNotification.name, object: self)
        notificationCenter.post(notification)
    }
}

// MARK: - Class Helpers
extension AlertCenter {
    
}

