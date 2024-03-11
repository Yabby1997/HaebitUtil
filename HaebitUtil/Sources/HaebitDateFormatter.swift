//
//  HaebitDateFormatter.swift
//  
//
//  Created by Seunghun on 3/5/24.
//

import Foundation

/// A date formatter for Haebit.
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
    
    /// Initializes new ``HaebitDateFormatter``.
    public init() {}
    
    /// Formats date part of `Date` with given locale in Haebit style.
    ///
    /// - Parameters:
    ///     - date: A `Date` value to format.
    ///     - locale: A `Locale` indiciating which language to format with.
    ///
    /// - Returns: A `String` indicating formatted result of given `Date` and `Locale`.
    ///
    /// - Note: This method doesn't formats the time part of the `Date`. Use ``formatTime(from:with:)`` for time formatting.
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
    
    /// Formats time part of `Date` with given locale in Haebit style.
    ///
    /// - Parameters:
    ///     - date: A `Date` value to format.
    ///     - locale: A `Locale` indiciating which language to format with.
    ///
    /// - Returns: A `String` indicating formatted result of given `Date` and `Locale`.
    ///
    /// - Note: This method doesn't formats the date part of the `Date`. Use ``formatDate(from:with:)`` for date formatting.
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
