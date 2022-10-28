import SwiftUI

let storage = DemoStorage()

struct AddDiaryView: View {
    
    @Binding var isAddViewShow:Bool
    
    @ObservedObject var storage: DemoStorage
    
    @EnvironmentObject var diaryFetcher: DiaryFetcher
    
    @State private var inputText: String = ""
    
    var body: some View {
            VStack(spacing: 30) {
                Text("2022년 8월 27일")
                    .font(.custom("Cafe24SsurroundAir", size: 26))
                TextEditor(text: $inputText)
                    .background(Color.red)
                    .foregroundColor(Color.black)
//                    .colorMultiply(Color(red: 1, green: 1, blue: 1, opacity: 0.5))
                    .frame(height: .infinity)
                
                HStack {
                    Button(action: {
                        storage.contents.append(DiaryList(content: inputText))
                        diaryFetcher.postDiary(content: inputText) {
                            diaryFetcher.getDiaries(parameters: ["size":"1000"])
                        }
                        isAddViewShow = false
                    }) {
                        Text("ADD")
                    }
                    Button(action: {
                        isAddViewShow = false
                    }) {
                        Text("CANCEL")
                    }
                }.frame(maxHeight: .infinity, alignment: .bottom)
            }
        .background(content: {
            Image("paper_background").resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        }).task {
        }
    }
}

struct AddDiary_Previews: PreviewProvider {
    static var previews: some View {
        AddDiaryView(isAddViewShow: .constant(true), storage: DemoStorage())
    }
}
