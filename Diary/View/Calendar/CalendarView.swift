
import SwiftUI

struct CalendarView: View {
    
    @State var isAddViewShow: Bool = false
    
    var body: some View {
        VStack {
            FSCalendarView()
            HStack {
                Spacer()
                Button {
                    isAddViewShow = true
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 50))
                        .foregroundColor(Color(red: 242/255, green: 163/255, blue: 27/255, opacity: 0.7))
                }

                
            }
        }
        .padding()
        .background {
            Image("paper_background").resizable()
                .ignoresSafeArea()
                .fullScreenCover(isPresented: $isAddViewShow) {
                    AddDiaryView(isAddViewShow: $isAddViewShow)
                }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
