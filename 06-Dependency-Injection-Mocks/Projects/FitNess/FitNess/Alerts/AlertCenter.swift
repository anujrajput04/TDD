import Foundation

class AlertCenter {
    static var instance = AlertCenter()
    
    // MARK: - Alert Queue
    private var alertQueue: [Alert] = []
    
    var alertCount: Int {
        return alertQueue.count
    }
    
    var topAlert: Alert? {
        return alertQueue.first
    }
    
    var nextUp: Alert? {
        return alertQueue.count >= 2 ? alertQueue[1] : nil
    }
    
    // MARK: - Lifecycle
    init(center: NotificationCenter = .default) {
        self.notificationCenter = center
    }
    
    // MARK: - Notifications
    let notificationCenter: NotificationCenter
    
    func postAlert(alert: Alert) {
        guard !alertQueue.contains(alert) else { return }
        
        alertQueue.append(alert)
        let notification = Notification(name: AlertNotification.name,
                                        object: self,
                                        userInfo: [AlertNotification.Keys.alert: alert])
        notificationCenter.post(notification)
    }
    
    // MARK: - Alert Handling
    func clear(alert: Alert) {
        if let index = alertQueue.firstIndex(of: alert) {
            alertQueue.remove(at: index)
        }
    }
    
    func clearAlerts() {
        alertQueue.removeAll()
    }
}

// MARK: - Class Helpers
extension AlertCenter {
    
    class func listenForAlerts(_ callback: @escaping (AlertCenter) -> ()) {
        instance.notificationCenter
            .addObserver(forName: AlertNotification.name,
                         object: instance, queue: .main) { _ in
                callback(instance)
            }
    }
}

