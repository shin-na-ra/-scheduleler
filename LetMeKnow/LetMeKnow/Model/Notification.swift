//
//  Notification.swift
//  LetMeKnow
//
//  Created by 신나라 on 6/20/24.
//

import SwiftUI
import UserNotifications

struct Notification {
    var id: String
    var title: String
}

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
    
    func addNotification(title: String) {
        notifications.append(Notification(id: UUID().uuidString, title: title))
    }
    
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings{settings in
            switch settings.authorizationStatus {
                case .notDetermined: self.requestPermission()
                case .authorized, .provisional: self.scheduleNotifications()
                default : break
            }
        }
    }
    
    func scheduleNotifications() {
        
        let dbModel = CalendarDB()
        
        for notification in notifications {
            
            //날짜 설정
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            
            //알림시간 설정
            let date = (dbModel.queryDB()[0].task[0].time)-1  // Date 타입의 값

            // DateComponents를 사용하여 시간을 추출
            let components = Calendar.current.dateComponents([.hour, .minute], from: date)

            // dateComponents에서 hour 속성을 가져와 할당
            dateComponents.hour = components.hour
            dateComponents.minute = components.minute
            
            
            let content = UNMutableNotificationContent()
            content.title = "🧐알려주게🧐"
            content.sound = .default
            content.subtitle = dbModel.queryDB()[0].task[0].title
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else {return}
                print("scheduling notification with id:\(notification.id)")
            }
            
        }
    }
    
    
    func cancleNotification() {
        // 곧 다가올 알림 지우기
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        //현재 폰에 떠 있는 알림 지우기
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func deleteBadgeNumber() {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
}
