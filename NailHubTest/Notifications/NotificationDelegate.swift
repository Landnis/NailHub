//
//  NotificationDelegate.swift
//  NailHubTest
//
//  Created by Konstantinos Stergiannis on 16/5/26.
//

import UserNotifications
import SwiftUI

final class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {

    static let shared = NotificationDelegate()

    var onTapAppointment: ((UUID) -> Void)?

    private override init() {}

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {

        let userInfo = response.notification.request.content.userInfo

        if let idString = userInfo["appointmentID"] as? String,
           let id = UUID(uuidString: idString) {

            DispatchQueue.main.async {
                self.onTapAppointment?(id)
            }
        }
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {

        return [.banner, .sound]
    }
}
