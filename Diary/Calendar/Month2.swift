import Foundation

class Month2: ObservableObject {
    
    private let calendar = Calendar.current
    
    var startDate: Date
    var selectableDays: Bool
    var today = Date()
    var registeredDate: [String: Bool] = [:]
    
    var monthNameYear: String {
        self.monthHeader()
    }
    var monthDays: [Int: [Day]] = [:]
    
    var monthRows: Int {
        self.rows()
    }
    
    init(startDate: Date, selectableDays: Bool) {
        self.startDate = startDate
        self.selectableDays = selectableDays
        self.monthDays = initDayArrays()
    }

    private func monthHeader() -> String {
        let components = calendar.dateComponents([.year, .month], from: startDate)
        let currentMonth = calendar.date(from: components)!
        return currentMonth.dateToString(format: "yyyy년 LLLL")
    }

    private func dateToString(date: Date, format: String) -> String {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = format
        let dateString = dateFormat.string(from: date)
        return dateString
    }

    public func firstOfMonth() -> Date {
        return startDate.startOfMonth
    }

    public func lastOfMonth() -> Date {
        return startDate.endOfMonth
    }

    private func dateToWeekday(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else {
            fatalError("Cannot convert weekday to Int")
        }
        return weekday
    }

    private func rows() -> Int {
        let columns = monthDays.count
        var rowCount = 1
        for col in 1...columns {
            if monthDays[col]!.count > rowCount {
                rowCount = monthDays[col]!.count
            }
        }
        return rowCount
    }

private func initDayArrays() -> [Int: [Day]] {
        var arrayOfDays = [
            1: [Day](),
            2: [Day](),
            3: [Day](),
            4: [Day](),
            5: [Day](),
            6: [Day](),
            7: [Day]()
        ]
        let fom = firstOfMonth()
        let lom = lastOfMonth()
        var currentDate = fom

        while (fom <= currentDate && currentDate <= lom) {
            //현재 날짜에 해당하는 요일 숫자를 가지고 온다.
            let weekday = dateToWeekday(date: currentDate)
            let disabled = currentDate > today ? true : false
            let currentDateInt = Int(currentDate.dateToString(format: "MMdyy"))!
            let todayDateInt = Int(today.dateToString(format: "MMdyy"))!
            let isToday = currentDateInt == todayDateInt ? true : false
            let currentDay = Day(date: currentDate, today: isToday, disable: disabled, selectable: selectableDays)
            arrayOfDays[weekday]?.append(currentDay)

            if fom == currentDate {
                var startDay = weekday - 1
                while startDay > 0 {
                    arrayOfDays[startDay]?.append(Day(date: Date(timeIntervalSince1970: 0)))
                    startDay -= 1
                }
            }

            //오늘이 달의 마지막 날이면
            if lom == currentDate {
                var endDay = weekday + 1
                while endDay <= 7 {
                    arrayOfDays[endDay]?.append(Day(date: Date(timeIntervalSince1970: 0)))
                    endDay += 1
                }
            }

            //날짜 1 증가
            var components = calendar.dateComponents([.day], from: currentDate)
            components.day = +1
            currentDate = calendar.date(byAdding: components, to: currentDate)!
        }

        return arrayOfDays
    }
}
