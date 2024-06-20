//
//  CalendarDetailView.swift
//  LetMeKnow
//
//  Created by 신나라 on 6/20/24.
//

import SwiftUI

struct CalendarDetailView: View {
    
    @State var task: Task                       //customDatePicker에서 선택한 task를 받아오는 변수
    @State var currentDate = Date()             //customDatePicker에서 선택한 currentDate를 받아오는 변수
    @FocusState var isTextFieldFocused: Bool    // 키보드 내리기 변수
    @State var isAlert = false                  // 확인 alert 변수
    @State var isAlarm = false                  // 경고 alert 변수
    @State var isFail = false                  // 경고 alert 변수
    @Environment(\.dismiss) var dismiss         // 화면 이동을 위한 변수
    let dbModel = CalendarDB()                  // CalendarDB instance 생성
    @State var alertType: AlertType?            // AlertType 지정하기
    @State var isDelete = false                   // 삭제여부 alert
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// AlertType 선언
enum AlertType: Identifiable {
    case success, failure, warning
    var id: Int {
        hashValue
    }
}

#Preview {
    CalendarDetailView(task: (Task(id: "1", title: "Dummy Task", time: Date(), status: 0)), currentDate:(Date()))
}
