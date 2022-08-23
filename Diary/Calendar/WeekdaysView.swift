import SwiftUI

struct WeekdaysView: View {
    let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
    let colors = Colors()

    var body: some View {
        HStack {
            GridStack(rows: 1, columns: 7) { row, col in
                Text(self.weekdays[col])
            }
        }.padding(.bottom, 20).background(colors.weekdayBackgroundColor)
    }
}

struct WeekdaysView_Previews: PreviewProvider {
    static var previews: some View {
        WeekdaysView()
    }
}
