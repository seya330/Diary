
import SwiftUI

struct CalendarView: View {
    var body: some View {
        VStack {
            FSCalendarView()
        }.padding().navigationBarTitle("Mood Calendar", displayMode: .inline)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
