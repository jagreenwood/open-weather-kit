import Foundation

extension DateFormatter {
    /// A DateFormatter configured for API date strings in YYYY-MM-DD format.
    /// Uses UTC timezone to avoid DST edge cases.
    @usableFromInline
    static let dateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

extension Date {
    /// Converts a Date to a YYYY-MM-DD string in UTC.
    @usableFromInline
    func toDateString() -> String {
        DateFormatter.dateOnly.string(from: self)
    }

    /// Creates a Date from a YYYY-MM-DD string in UTC.
    /// - Parameter dateString: String in YYYY-MM-DD format
    /// - Returns: Date object or nil if parsing fails
    @usableFromInline
    static func fromDateString(_ dateString: String) -> Date? {
        DateFormatter.dateOnly.date(from: dateString)
    }
}
