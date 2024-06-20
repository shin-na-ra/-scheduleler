//
//  CalendarAddView.swift
//  LetMeKnow
//
//  Created by 신나라 on 6/20/24.
//

import SwiftUI

struct CalendarAddView: View {
    
    @State var date: Date = Date()              // 선택된 날짜 변수
    @State var time: Date = Date()              // 선택된 시간 변수
    @State var task: String = ""
    @State var status: Int = 0
    @State var checked: Bool = false
    @FocusState var isTextFieldFocused: Bool    // 키보드 focus
    let dbModel = CalendarDB()
    @State var isSubAlert = false            // subAlert 실행
    @Environment(\.dismiss) var dismiss         // 화면 이동을 위한 변수
    
    var body: some View {
        VStack(content: {
                
            //일정 textfield
            TextField("일정 제목", text: $task)
                .font(.title3.bold())
                .frame(width: 200)
                .padding()
                .cornerRadius(8)
                .focused($isTextFieldFocused)
            
            //요일 설정 picker
            DatePicker(
                "요일 설정 : ",
                selection: $date,
                displayedComponents: [.date]
            )
            .frame(width: 200)
            .environment(\.locale, Locale(identifier: "ko_KR")) // 한국어로 설정
            .tint(Color("color1"))
            
            //시간 설정 picker
            DatePicker(
                "시간 설정 : ",
                selection: $time,
                displayedComponents: [.hourAndMinute]
            )
            .frame(maxWidth: 200)
            .environment(\.locale, Locale(identifier: "ko_KR")) // 한국어로 설정
            .tint(Color("color1"))
        
            HStack(content: {
                Text("완료")
                Image(systemName: checked ? "checkmark.square.fill" : "square")
                    .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
                    .onTapGesture {
                        self.checked.toggle()
                        checked ? status = 1 : (status = 0)
                        print("checked : ", checked)
                        print("status : ", status)
                        
                    }
            })//HStack
            .padding(.top, 10)
            .padding(.trailing, 140)
            
            //추가 버튼
            Button("추가하기", action: {
                if task != "" {
                    let newTask = Task(id: UUID().uuidString, title: task, time: time, status: status)
                    dbModel.insertDB(task: newTask, taskDate: date)
                    dismiss()
                } else {
                    isSubAlert = true
                }
                
                //추가 후 초기화처리
                task = ""
                date = Date()
                time = Date()
            }) // Button
            .tint(.white)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .background(Color("color1"))
            .cornerRadius(30)
            .controlSize(.large)
            .frame(width: 200, height: 50) // 버튼의 크기 조정
            .padding(.top, 40)
            
            // 일정 == empty일 때, alert처리
            .alert(isPresented: $isSubAlert) {
                Alert(
                    title: Text("경고"),
                    message: Text("일정을 작성해주세요."),
                    dismissButton: .default(Text("확인"), action: {
                        isSubAlert = false
                    })
                )
            }// alert
        })// Vstck
    }
}

#Preview {
    CalendarAddView()
}
