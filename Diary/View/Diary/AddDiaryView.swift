import SwiftUI

struct AddDiaryView: View {
    
    @Binding var isAddViewShow:Bool
    
    @EnvironmentObject var diaryFetcher: DiaryFetcher
    
    @EnvironmentObject var obj: observed
    
    @State private var inputText: String = ""
    
    var body: some View {
            VStack(spacing: 30) {
                ZStack {
                    Text(Date().getDateDotString())
                        .font(.custom("Cafe24SsurroundAir", size: 26))
                        .foregroundColor(.black.opacity(0.5))
                    HStack {
                        Spacer()
                        Button {
                            isAddViewShow = false
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.red.opacity(0.6))
                                .font(.system(size: 26))
                        }.padding([.trailing], 10)
                    }
                }
                ScrollView {
                    MultiTextField().frame(height: self.obj.size).padding(10)
                        
                }
                //footer
                HStack {
                    Spacer()
                    Button {
                        diaryFetcher.postDiary(content: inputText) {
                                                    diaryFetcher.getDiaries(parameters: ["size":"1000"])
                                                }
                        isAddViewShow = false
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.black)
                            .font(.system(size: 30))
                            .padding([.trailing, .bottom], 10)
                    }
                    
                }
                
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
        AddDiaryView(isAddViewShow: .constant(true)).environmentObject(observed())
    }
}
