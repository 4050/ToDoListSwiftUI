//
//  CurrentDate.swift
//  ToDoList
//
//  Created by Станислав on 07.10.2023.
//

import Foundation

enum CurrentDate {
    static func today() -> Date {
        return Calendar.current.startOfDay(for: Date())
    }

    static func tomorrow() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: today())!
    }
}
