import Foundation

class User: ObservableObject {
    
    init(email: String, fullName: String, givenName: String, familyName: String) {
        self.email = email
        self.fullName = fullName
        self.givenName = givenName
        self.familyName = familyName
    }
    
    var email: String
    
    var fullName: String
    
    var givenName: String
    
    var familyName: String
}
