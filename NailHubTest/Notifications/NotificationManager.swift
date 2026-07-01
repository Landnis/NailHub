//
//  NotificationManager.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/5/26.
//

import Foundation
import UserNotifications

final class NotificationManager {

    static let shared = NotificationManager()
    let minutesBefore: Int = 120
    private init() {}

    func requestPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in

                if granted {
                    print("Notifications enabled")
                } else if let error {
                    print(error.localizedDescription)
                }
            }
    }
    
    func scheduleNotification(for appointment: AppointmentModel, minutesBefore: Int = 120) {
        
        removeNotification(for: appointment)
        
        
        let content = UNMutableNotificationContent()
        content.title = "Υπενθύμιση Ραντεβού"
        let hoursBefore = minutesBefore / 60
        content.body = "Το ραντεβού με \(appointment.clientName) ξεκινά σε \(hoursBefore) ώρες."
        content.sound = .default
        
        // εδω σετταρω ποσα λεπτά πριν θελω να ερθει push notification.
        guard let triggerDate = Calendar.current.date(
            byAdding: .minute,
            value: -minutesBefore,
            to: appointment.date
        ) else { return }

        // Αν η ώρα πέρασε ήδη, μην στείλεις notification
        if triggerDate < Date() {
            print("Skipped notification – too late")
            return
        }

        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: triggerDate
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: appointment.id.uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    func removeNotification(for appointment: AppointmentModel) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(
                withIdentifiers: [appointment.id.uuidString]
            )
    }
}
