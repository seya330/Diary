
import SwiftUI

public struct CalendarView: View {
    let startDate: Date
    let monthsToDisplay: Int
    var selectableDays = true
    @State var registeredDateDic: [String: Bool] = [:]
    
    @EnvironmentObject var diaryFetcher: DiaryFetcher
    
    @State var isLoaded: Bool = false
    
    var month: Month2
    
    init(start: Date, monthsToShow: Int, daysSelectable: Bool = true) {
    self.startDate = start
    self.monthsToDisplay = monthsToShow
    self.selectableDays = daysSelectable
        self.month = Month2(startDate: startDate, selectableDays: selectableDays)
    }

    public var body: some View {
        VStack {
            WeekdaysView()
            if !isLoaded {
                Text("Loading...")
            } else {
                ScrollView {
                    MonthView(month: month)
                }
                Spacer()
            }
        }.padding().navigationBarTitle("Mood Calendar", displayMode: .inline)
            .task {
                let first: Date = month.firstOfMonth()
                let last: Date = month.lastOfMonth()
                diaryFetcher.getDiaryRegisteredDates(
                    startDate: DateFactory.of(year: first.year, month: first.month, day: first.day),
                    endDate: DateFactory.of(year: last.year, month: last.month, day: last.day)
                ) {
                    let format: DateFormatter = DateFormatter()
                    format.dateFormat = "yyyy-MM-dd"
                    diaryFetcher.registeredDates.forEach { date in
                        self.registeredDateDic[format.string(from: date)] = true
                    }
                    month.registeredDate = self.registeredDateDic
                    isLoaded = true
                }
            }
    }

    func nextMonth(currentMonth: Date, add: Int) -> Date {
        var components = DateComponents()
        components.month = add
        let next = Calendar.current.date(byAdding: components, to: currentMonth)!
        return next
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(start: Date(), monthsToShow: 1).environmentObject(DiaryFetcher())
    }
}
