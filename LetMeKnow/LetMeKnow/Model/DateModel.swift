//
//  DateModel.swift
//  LetMeKnow
//
//  Created by 신나라 on 6/20/24.
//

import SwiftUI

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
