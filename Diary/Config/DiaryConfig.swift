import Foundation
struct DiaryConfig {
    static var baseUrl: String {
        guard let baseUrl = Bundle.main.infoDictionary?["diaryServerUrl"] as? String else {
            fatalError("diary server url not set")
        }
        return baseUrl
    }
}
