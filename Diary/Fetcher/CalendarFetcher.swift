import Foundation
import Alamofire

class CalendarFetcher: ObservableObject {
    
    private let decoder: JSONDecoder
    
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
    }
}
