import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func scheduleMatchNotification(match: Match, team: Team) {
        let content = UNMutableNotificationContent()
        content.title = "Match à venir pour \(team.name)"
        content.body = "Contre : \(match.opponent) le \(DateFormatter.localizedString(from: match.date, dateStyle: .medium, timeStyle: .short))"
        content.sound = .default
        
        let triggerDate = match.date
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(triggerDate.timeIntervalSinceNow, 5), repeats: false)
        let request = UNNotificationRequest(identifier: match.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erreur lors de la planification de la notif :", error)
            }
        }
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
} 