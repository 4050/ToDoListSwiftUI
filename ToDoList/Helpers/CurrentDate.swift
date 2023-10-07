//
//  CurrentDate.swift
//  ToDoList
//
//  Created by Станислав on 07.10.2023.
//

import Foundation

enum CurrentDate {
    static func today() -> Date {
        return Calendar.current.startOfDay(for: Date.init())
    }

    static func tomorrow() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: today())!
    }
    
    static func future() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: tomorrow())!
    }
    
    static func areDatesEqualIgnoringTime(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
        
        return components1 == components2
    }
}
