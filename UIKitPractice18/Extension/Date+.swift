//
//  Date+.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/24/25.
//

import Foundation

extension Date {
    var yesterday: Date {
        Calendar.current.date(byAdding: DateComponents(day: -1), to: self)!
    }
}
