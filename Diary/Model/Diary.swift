import Foundation

class DiaryList: Identifiable {
    
    let id: UUID
    
    let seq: Int64
    
    let content: String
    
    let registeredAt: Date
    
    init(content:String) {
        self.id = UUID()
        self.seq = 1
        self.content = content
        self.registeredAt = Date()
    }
    
    init(seq: Int64, content: String, registeredAt: Date) {
        self.id = UUID()
        self.seq = seq
        self.content = content
        self.registeredAt = registeredAt
    }
    
}

class DiaryDecodable: Decodable {
    
    let seq: Int64
    
    let content: String?
    
    let registeredAt: Date
}

class Diary {
    let seq: Int64
    let content: String
    let registeredAt: Date
    
    init(content: String) {
        self.seq = 1
        self.content = content
        self.registeredAt = Date()
    }
    
    init(seq:Int64, content: String, registeredAt: Date) {
        self.seq = seq
        self.content = content
        self.registeredAt = registeredAt
    }
    
    static let defaultDiary = Diary(content: "")
}
