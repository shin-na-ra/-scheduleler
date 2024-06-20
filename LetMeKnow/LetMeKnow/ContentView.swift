//
//  ContentView.swift
//  LetMeKnow
//
//  Created by 신나라 on 6/20/24.
//


import SwiftUI

struct ContentView: View {
    
    @State var currentDate: Date = Date()
    let dbModel = CalendarDB()
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) { // showsIndicators : false => 스크롤바 안보이게
                // 달력 뷰
                VStack(spacing: 20, content: {
                    CustomDatePicker(currentDate: currentDate, dateValue: $currentDate)
                })
                .padding(.vertical)
            }
            .navigationTitle("알려주게")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                setNotification()
            })
        }
        
    }//body
    
    /* notification 푸시 알림*/
    func setNotification() {
        let manager = NotificationManager()
        manager.addNotification(title: "hello")
        manager.scheduleNotifications()
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    ContentView()
}
