import Foundation
import Alamofire
import GoogleSignIn
import GoogleSignInSwift

class AuthManager: ObservableObject {
    
    @Published var isLogined: Bool = false
    
    var loginUser: User?
    
    public static let googleConfig = GIDConfiguration(clientID: "151749810455-43v7cd4lnk8j09ftf98j2eu0bt5f77oa.apps.googleusercontent.com")
    
    func googleLogin() {
        GIDSignIn.sharedInstance.signIn(with: AuthManager.googleConfig, presenting: presentingViewController!) {
            user, error in
            
            guard error == nil else {return}
            guard let user else {return}
            
            user.authentication.do { auth, error in
                guard error == nil else {return}
                guard let auth else {return}
                guard let token = auth.idToken else {return}
                
                AF.request(DiaryConfig.baseUrl + "/auth/google", method: .post, parameters: ["token": token], encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: User.self, completionHandler: { response in
                    switch response.result {
                    case .success(let response):
                        self.loginUser = response
                        self.isLogined = true
                    case .failure(let error):
                        print(error)
                    }
                })
            }
        }
    }
  
  func refreshGoogleLogin(user: GIDGoogleUser) {
    user.authentication.do { auth, error in
        guard error == nil else {return}
        guard let auth else {return}
        guard let token = auth.idToken else {return}
        
        AF.request(DiaryConfig.baseUrl + "/auth/google", method: .post, parameters: ["token": token], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: User.self, completionHandler: { response in
            switch response.result {
            case .success(let response):
                self.loginUser = response
                self.isLogined = true
            case .failure(let error):
                print(error)
            }
        })
    }
  }
}
