//
//  NotifcationScheduler.swift
//  EventManagementCD
//
//  Created by Regina Paek on 6/25/22.
//

import UserNotifications

class NotificationScheduler {
    
    func scheduleNotification(for event: Event) {
        
        guard let eventDate = event.eventDate,
              let identifier = event.id else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "It's time for \(event.title ?? "Event!!")"
        content.sound = .default
        content.categoryIdentifier = Strings.eventNotificationCategoryId
        content.userInfo = ["eventId": identifier]
        
        let fireDateComponents = Calendar.current.dateComponents([.hour, .minute], from: eventDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Unable to add notification request: \(error.localizedDescription)")
            }
        }
    }
    func clearNotifications(for event: Event) {
        guard let identifier = event.id else { return }
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
