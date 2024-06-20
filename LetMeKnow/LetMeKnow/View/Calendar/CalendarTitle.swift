//
//  CalendarTitle.swift
//  LetMeKnow
//
//  Created by 신나라 on 6/20/24.
//

import SwiftUI

struct CalendarTitle: View {
    
    @Binding var currentDate: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10 ,content: {
        
            Text(extraDate()[0])
                .font(.caption)
                .fontWeight(.semibold)
            
            Text("\(extraDate()[1])월")
                .font(.title.bold())
            
        })//VStack
    }
    
    /* MARK: 년도와 월 정보 가져오기 */
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM" //2024 06로 반환
        
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
}

