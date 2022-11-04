
import SwiftUI

struct CalendarView: View {
    
    @State var isAddViewShow: Bool = false
    
    @State var isShowDetailView: Bool = false
    
    @State var selectedSeq: Int64 = 1
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: DiaryDetilView(diarySeq: selectedSeq), isActive: $isShowDetailView) {EmptyView()}
                FSCalendarView(isShowDetailView: $isShowDetailView, seq: $selectedSeq)
                HStack {
                    Spacer()
                    Button {
                        isAddViewShow = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 50))
                            .foregroundColor(Color(red: 242/255, green: 163/255, blue: 27/255, opacity: 0.5))
                            .shadow(color: .gray, radius: 1, x: 2, y: 2)
                    }
                }
            }
            .navigationTitle("")
            .padding()
            .background {
                Image("paper_background").resizable()
                    .ignoresSafeArea()
                    .fullScreenCover(isPresented: $isAddViewShow) {
                        AddDiaryView(isAddViewShow: $isAddViewShow)
                    }
            }
        }
        .tint(Color(red: 242/255, green: 163/255, blue: 27/255, opacity: 1.0))
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
