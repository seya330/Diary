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
        DiaryDetilView(diarySeq: 1)
    }
}

struct DiaryDetailViewImpl: View {
    
    let diary: Diary
    
    var body: some View {
        VStack {
            Text("작성일 " + dateToString(date: diary.registeredAt))
            Divider()
            Spacer()
            Section {
                VStack(spacing: 10) {
                    ScrollView(showsIndicators: false) {
                        Text(diary.content)
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 239/255, green: 243/255, blue: 244/255, opacity: 1))
            .cornerRadius(20)
        }
    }
}
