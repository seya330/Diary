import Foundation
class DemoStorage: ObservableObject {
    
    @Published var contents: [DiaryList] = [];
    
    init() {
        self.contents.append(DiaryList(content: "asdfadsfasdf"))
    }
}
