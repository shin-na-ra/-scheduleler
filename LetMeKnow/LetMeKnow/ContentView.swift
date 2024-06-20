//
//  ContentView.swift
//  LetMeKnow
//
//  Created by 신나라 on 6/20/24.
//


import SwiftUI

struct ContentView: View {
    
    @State var currentDate: Date = Date()
    @State var isAlert = false            // actionSheet 실행
    @State var isSubAlert = false            // subAlert 실행
    @State var isResultTrue = false
    @State var isResultFalse = false
    @State var task: String = ""                // 입력받을 일정 변수
    @FocusState var isTextFieldFocused: Bool    // 키보드 focus
    @State var date: Date = Date()              // 선택된 날짜 변수
    @State var time: Date = Date()              // 선택된 시간 변수
    let dbModel = CalendarDB()
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) { // showsIndicators : false => 스크롤바 안보이게
                
                VStack(spacing: 20, content: {
                    
                    //Custom Picker View
                    CustomDatePicker(currentDate: $currentDate, dateValue: $currentDate)
                    
                })//VStack
                .padding(.vertical)
            }//ScrollView
            .navigationTitle("알려주게")
            .navigationBarTitleDisplayMode(.inline)
        }
    }//body
    
    
    /* 날짜 체크 */
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }


#Preview {
    ContentView()
}
