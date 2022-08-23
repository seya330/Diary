import SwiftUI

struct MonthView: View {
    
    @ObservedObject var month: Month2
    
    var registeredDate: [String: Bool]
    
    let format: DateFormatter

    var body: some View {
        VStack {
            //여기서 row가 3에서 끝나야 하는데 왜 4로 가지?
            GridStack(rows: month.monthRows, columns: month.monthDays.count) { row, col in
                if self.month.monthDays[col+1]![row].dayDate == Date(timeIntervalSince1970: 0) {
                    Text("").frame(width: 32, height: 32)
                } else {
                    let isWrited: Bool = registeredDate[format.string(from: self.month.monthDays[col+1]![row].dayDate)] ?? false
                    DayCellView(day: self.month.monthDays[col+1]![row],
                                isWritedDiary: isWrited)
                }
            }
        }
        .padding(.bottom, 20)
    }
    
    init(month: Month2) {
        self.month = month
        self.registeredDate = month.registeredDate
        format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(month: Month2(startDate: Date(), selectableDays: true))
    }
}
