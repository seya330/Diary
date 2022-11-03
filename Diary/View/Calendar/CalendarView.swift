
import SwiftUI

struct CalendarView: View {
    var body: some View {
        VStack {
            FSCalendarView()
        }
        .padding()
        .background {
            Image("paper_background").resizable()
                .ignoresSafeArea()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
