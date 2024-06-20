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
    @State var status = 0
    @State var checked : Bool = false
    
    var body: some View {
        
        VStack(content: {
            
            Spacer()
            
            Button(action: {
                isDelete = true
            }, label: {
                Image(systemName: "trash")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
            })
            .alert(isPresented: $isDelete, content: {
                Alert(
                    title: Text("알림"),
                    message: Text("일정을 삭제하시겠습니까?"),
                    primaryButton: .destructive(Text("확인"), action: {
                        dbModel.deleteDB(id: task.id)
                        dismiss()
                    }),
                    secondaryButton: .cancel(Text("취소"), action: {
                        isDelete = false
                    })
                )
            })
            
            Spacer()
            
            //일정 textfield
            TextField("일정 제목", text: $task.title)
                .font(.title3.bold())
                .frame(width: 200)
                .padding()
                .cornerRadius(8)
                .focused($isTextFieldFocused)
            
            
            //요일 설정 picker
            DatePicker(
                "요일 설정 : ",
                selection: $currentDate,
                displayedComponents: [.date]
            )
            .frame(width: 200)
            .environment(\.locale, Locale(identifier: "ko_KR")) // 한국어로 설정
            .tint(Color("color1"))
            
            //시간 설정 picker
            DatePicker(
                "시간 설정 : ",
                selection: $task.time,
                displayedComponents: [.hourAndMinute]
            )
            .frame(maxWidth: 200)
            .environment(\.locale, Locale(identifier: "ko_KR")) // 한국어로 설정
            .tint(Color("color1"))
            
            HStack(content: {
                Text("완료")
                Image(systemName: task.status == 1 ? "checkmark.square.fill" : "square")
                    .foregroundColor(task.status == 1 ? Color(UIColor.systemBlue) : Color.secondary)
                    .onTapGesture {
                        // checked 값을 토글하면서 상태 업데이트
                        let newChecked = task.status == 0
                        task.status = newChecked ? 1 : 0
                        print("checked: ", newChecked)
                        print("status: ", task.status)
                    }
            })//HStack
            .padding(.top, 10)
            .padding(.trailing, 140)
            
            Button("수정하기", action: {
                if task.title != "" {
                    let result = dbModel.updateDB(title: task.title, time: task.time, taskDate: currentDate, status: task.status, id: task.id)
                    alertType = result ? .success : .failure
                    isTextFieldFocused = false
                    
                } else {
                    alertType = .warning
                }
                
            }) // Button
            .tint(.white)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .background(Color("color1"))
            .cornerRadius(30)
            .controlSize(.large)
            .frame(width: 200, height: 50) // 버튼의 크기 조정
            .padding(.top, 40)
            .alert(item: $alertType) { alertType in
                print("aaa",alertType)
                switch alertType {
                    case .success :
                        return Alert(
                            title: Text("알림"),
                            message: Text("수정되었습니다."),
                            dismissButton: .default(Text("확인"), action: {
                                dismiss()
                                dismiss()
                            })
                        )// Alert
                    
                    case .failure :
                        return Alert(
                            title: Text("알림"),
                            message: Text("수정에 실패했습니다."),
                            dismissButton: .default(Text("확인"))
                        )// Alert
                    
                    case .warning :
                        return Alert(
                            title: Text("경고"),
                            message: Text("일정을 작성해주세요."),
                            dismissButton: .default(Text("확인"))
                        )// Alert
                }
            }// alert
            
            Spacer()
            
        }) //VStack
    } //body
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
