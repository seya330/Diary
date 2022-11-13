import Foundation

class User: Decodable {
    
    init(token: String, email: String, name: String) {
        self.token = token
        self.email = email
        self.name = name
    }
    
    var token: String
    
    var email: String
    
    var name: String?
}
