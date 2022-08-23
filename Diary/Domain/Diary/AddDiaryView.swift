import SwiftUI

let storage = DemoStorage()

struct AddDiaryView: View {
    
    @Binding var isAddViewShow:Bool
    
    @ObservedObject var storage: DemoStorage
    
    @EnvironmentObject var diaryFetcher: DiaryFetcher
    
    @State private var inputText: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Write Diary")
                .font(.largeTitle)
            TextEditor(text: $inputText)
                .cornerRadius(20)
                .foregroundColor(Color.red)
                .colorMultiply(Color(red: 239/255, green: 243/255, blue: 244/255, opacity: 1))
                .frame(height: 200)
                .padding()
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
            }
            Spacer()
        }
    }
}

struct AddDiary_Previews: PreviewProvider {
    static var previews: some View {
        AddDiaryView(isAddViewShow: .constant(true), storage: DemoStorage())
    }
}
