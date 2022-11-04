import SwiftUI

struct DiaryDetilView: View {
    
    let diarySeq: Int64
    
    @State private var isLoaded: Bool = false
    
    @EnvironmentObject var diaryFetcher: DiaryFetcher
    
    init(diarySeq: Int64) {
        self.diarySeq = diarySeq
    }
    
    var body: some View {
        if !isLoaded {
            Text("Loading..")
                .task {
                    diaryFetcher.getDiary(seq: diarySeq) {
                        isLoaded = true
                    }
                    
                }
        } else {
            DiaryDetailViewImpl(diary: diaryFetcher.recentDiary)
            
        }
    }
}


func dateToString(date: Date) -> String {
    date.dateToString(format: "yyyy-MM-dd")
}

struct DiaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryDetilView(diarySeq: 1).environmentObject(DiaryFetcher())
    }
}

struct DiaryDetailViewImpl: View {
    
    let diary: Diary
    
    var body: some View {
        VStack {
            HStack {
                line
                line
                line
                line
                line
                Text(dateToString(date: diary.registeredAt))
                    .font(Font.custom("ACCchildrenheart", size: 22))
                    .foregroundColor(Color(red: 242/255, green: 163/255, blue: 27/255, opacity: 1))
                    .frame(width: 120)
                line
            }
//            .padding(.top, 10)
            Section {
                ScrollView {
                    Text(diary.content)
                        .font(Font.custom("ACCchildrenheart", size: 22))
                        .foregroundColor(.black.opacity(0.7))
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.clear)
            .cornerRadius(20)
        }.background {
            Image("paper_background").resizable()
                .ignoresSafeArea()
        }
    }
    
    var line: some View {
        VStack {
            Divider()
                .frame(height: 4)
                .overlay(Color(red: 242/255, green: 163/255, blue: 27/255, opacity: 0.2))
                .padding([.leading, .trailing], -4)
        }
    }
}
