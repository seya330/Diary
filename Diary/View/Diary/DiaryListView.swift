import SwiftUI

struct DiaryListView: View {
    
    @State private var isAddViewShow: Bool = false
    
    @State private var isLoadedContents: Bool = false
    
    @EnvironmentObject var diaryFetcher: DiaryFetcher
    
    var body: some View {
        VStack(spacing: 20) {
            if !isLoadedContents || diaryFetcher.diaries.isEmpty {
                Text("contents is empty")
            } else {
                NavigationView {
                    ZStack {
                        List {
                            ForEach(diaryFetcher.diaries) { content in
                                NavigationLink(destination: DiaryDetilView(diarySeq: content.seq)) {
                                    HStack {
                                        Text(content.content)
                                        Text(content.registeredAt.myFormat())
                                    }
                                }
                            }
                            .onDelete(perform: deleteDiary)
                        }
                    }
                }.background(content: {
                    Image("paper_background").resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                })
            }
            Button(action: {isAddViewShow = true}) {
                Text("Add")
            }
        }
        .fullScreenCover(isPresented: $isAddViewShow) {
            AddDiaryView(isAddViewShow: $isAddViewShow)
        }.task {
            diaryFetcher.getDiaries(parameters: ["size":"1000"]) {
                isLoadedContents = true
            }
        }
    }
    
    func deleteDiary (at offsets: IndexSet) {
        
    }
}

struct DiaryListView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView().environmentObject(DiaryFetcher())
    }
}

extension Date {
    public var year: Int {
            return Calendar.current.component(.year, from: self)
        }
        
        public var month: Int {
             return Calendar.current.component(.month, from: self)
        }
        
        public var day: Int {
             return Calendar.current.component(.day, from: self)
        }
    
    public func myFormat() -> String {
        return "\(year)년 \(month)월 \(day)일"
    }
}
