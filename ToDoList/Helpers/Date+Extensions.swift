//
//  Date+Extensions.swift
//  ToDoList
//
//  Created by Станислав on 02.09.2023.
//

import Foundation

extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
