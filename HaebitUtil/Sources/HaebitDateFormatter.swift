//
//  HaebitDateFormatter.swift
//  
//
//  Created by Seunghun on 3/5/24.
//

import Foundation

public final class HaebitDateFormatter {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        return dateFormatter
    }()
    
    private let relativeDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }()
    
    public init() {}
    
    public func formatDate(from date: Date, with locale: Locale = .current) -> String {
        if date.isToday || date.isYesterday {
            relativeDateFormatter.locale = locale
            return relativeDateFormatter.string(from: date)
        } else if date.isInAWeek {
            dateFormatter.locale = locale
            dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
            return dateFormatter.string(from: date)
        } else if date.isThisYear {
            dateFormatter.locale = locale
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
            return dateFormatter.string(from: date)
        } else {
            dateFormatter.locale = locale
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMMdy")
            return dateFormatter.string(from: date)
        }
    }
    
    public func formatTime(from date: Date, with locale: Locale = .current) -> String {
        dateFormatter.locale = locale
        dateFormatter.setLocalizedDateFormatFromTemplate("HHmm")
        return dateFormatter.string(from: date)
    }
}

extension Date {
    fileprivate var isThisYear: Bool { Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year) }
    fileprivate var isYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    fileprivate var isToday: Bool { Calendar.current.isDateInToday(self) }
    fileprivate var isInAWeek: Bool {
        guard let diff = Calendar.current.dateComponents([.day], from: self,  to: Date()).day else {
            return false
        }
        return diff < 7 && diff >= 0
    }
}
