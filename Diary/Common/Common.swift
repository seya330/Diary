import Foundation
import Alamofire
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

extension Date {
    
    func getDateTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.string(from: self)
    }
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func getDateDotString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
    
    func plusDays(_ days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func minusDays(_ days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -days, to: self)!
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.day = -1
        let lastOfMonth = Calendar.current.date(byAdding: components, to: startOfMonth)!
        return lastOfMonth
    }
}

class DateFactory {
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sss"
        return dateFormatter
    }()
    
    static func of(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let yearStr: String = String(year)
        let monthStr: String = month < 10 ? "0" + String(month) : String(month)
        let dayStr: String = day < 10 ? "0" + String(day) : String(day)
        let hourStr: String = hour < 10 ? "0" + String(hour) : String(hour)
        let minuteStr: String = minute < 10 ? "0" + String(minute) : String(minute)
        let secondStr: String = second < 10 ? "0" + String(second) : String(second)
        
        let str: String = "\(yearStr)-\(monthStr)-\(dayStr)T\(hourStr):\(minuteStr):\(secondStr)"
        return dateFormatter.date(from: str) ?? Date()
    }
}

struct FullBackground: View {
    
    let imageName: String
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .ignoresSafeArea()
            }
        }
    }
    
}

class AuthManager {
    
    public static let googleConfig = GIDConfiguration(clientID: "151749810455-43v7cd4lnk8j09ftf98j2eu0bt5f77oa.apps.googleusercontent.com")
    
    static func googleLogin() {
        GIDSignIn.sharedInstance.signIn(with: AuthManager.googleConfig, presenting: presentingViewController!) {
            user, error in
            
            guard error == nil else {return}
            guard let user else {return}
            
            let email = user.profile?.email
            let fullName = user.profile?.name
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            user.authentication.do { auth, error in
                guard error == nil else {return}
                guard let auth else {return}
                guard let token = auth.idToken else {return}
                
                AF.request(DiaryConfig.baseUrl + "/auth/google", method: .post, parameters: [
                    "token": token
                ], encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case let .failure(error):
                        print(error)
                    case .success(_):
                        print("success")
                    }
                }
            }
        }
    }
}

let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController
