import Foundation
import Alamofire

extension Date {
    
    func getDateTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.string(from: self)
    }
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.day = -1
        let lastOfMonth = Calendar.current.date(byAdding: components, to: startOfMonth)!
        return lastOfMonth
    }
}

class DateFactory {
    
    static func of(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let yearStr: String = String(year)
        let monthStr: String = month < 10 ? "0" + String(month) : String(month)
        let dayStr: String = day < 10 ? "0" + String(day) : String(day)
        let hourStr: String = hour < 10 ? "0" + String(hour) : String(hour)
        let minuteStr: String = minute < 10 ? "0" + String(minute) : String(minute)
        let secondStr: String = second < 10 ? "0" + String(second) : String(second)
        
        let str: String = "\(yearStr)-\(monthStr)-\(dayStr)T\(hourStr):\(minuteStr):\(secondStr)"
        return dateFormatter.date(from: str) ?? Date()
    }
}
