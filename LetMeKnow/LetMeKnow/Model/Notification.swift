//
//  Notification.swift
//  LetMeKnow
//
//  Created by 신나라 on 6/20/24.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    
    var notifications = [Notification]()
    
    //permission 함수
    func requestPermission() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error{
                print("Error : \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings{settings in
            switch settings.authorizationStatus {
                case .notDetermined: self.requestPermission()
                case .authorized, provisional: self.scheduleNotifications()
                default : break
            }
        }
    }
}
