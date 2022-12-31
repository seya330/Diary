import Foundation
import Alamofire

final class AnythingApiClient: ObservableObject {
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.headers = [:]
        
        return Session(configuration: configuration)
    }()
    
    private let decoder: JSONDecoder
    
    private let encoder: JSONEncoder
    
    @Published var recentDiary: Diary = Diary.defaultDiary
    
    @Published var diaries: [DiaryList] = []
    
    @Published var registeredSeq: [Date: Int64] = [:]
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
    }
    
    func postTodo(todoItem: TodoItem) {
        AF.request(DiaryConfig.baseUrl + "/api/todos",
                   method: .post,
                   parameters: toPayload(todoItem),
                   encoding: JSONEncoding.default, headers: authHeader())
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
    
    func modifyStarred(seq: Int64, isStarred: Bool) async -> Bool{
        let request = AF.request(DiaryConfig.baseUrl + "/api/todos/starred", method: .put, parameters: ["seq": seq, "isStarred": isStarred], encoding: JSONEncoding.default, headers: authHeader())
            .validate(statusCode: 200..<300)
            .serializingData()
        let result = await request.result
        if case let Result.failure(error) = result {
            print(error)
            return false
        }
        return true
    }
    
    func modifyCompleted(seq: Int64, isCompleted: Bool) async -> Bool {
        let request = AF.request(DiaryConfig.baseUrl + "/api/todos/completed",
                                 method: .put,
                                 parameters: ["seq": seq, "isCompleted": isCompleted],
                                 encoding: JSONEncoding.default, headers: authHeader())
            .serializingData()
        let result = await request.result
        if case let Result.failure(error) = result {
            print(error)
            return false
        }
        return true
    }
    
    func postDiary(content: String, completion: @escaping () -> Void = {}) {
        AF.request(DiaryConfig.baseUrl + "/api/diaries", method: .post, parameters: [
            "content": content
        ], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case let .failure(error):
                print(error)
            case .success(_):
                completion()
            }
        }
    }
    
    func getDiaries(parameters: Parameters, completion: @escaping () -> Void = {}) {
        AF.request(DiaryConfig.baseUrl + "/api/diaries", method: .get, parameters: parameters, encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PageResult<DiaryDecodable>.self, decoder: decoder) { response in
                switch response.result {
                case .success(let response):
                    self.diaries.removeAll()
                    for diaryDecodable in response.content {
                        self.diaries.append(DiaryList(seq: diaryDecodable.seq, content: diaryDecodable.content!, registeredAt: diaryDecodable.registeredAt))
                    }
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func getDiary(seq: Int64, completion: @escaping () -> Void) {
        AF.request(DiaryConfig.baseUrl + "/api/diaries/\(seq)", method: .get,encoding: URLEncoding.default, headers: authHeader())
            .validate(statusCode: 200..<300)
            .responseDecodable(of: DiaryDecodable.self, decoder: decoder) { response in
                switch response.result {
                case .success(let response):
                    self.recentDiary = Diary(seq: response.seq, content: response.content!, registeredAt: response.registeredAt)
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func getDiaryRegisteredDates(startDate: Date, endDate: Date, completion: @escaping () -> Void = {}) {
        let parameters: Parameters = [
            "startDate": startDate.getDateString(),
            "endDate": endDate.getDateString()
        ]
        
        AF.request(DiaryConfig.baseUrl + "/api/diaries/registered-date", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: authHeader())
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [String: Int64].self) { response in
                switch(response.result) {
                case .success(let body):
                    body.forEach { (key: String, value: Int64) in
                        guard let date = DateFactory.dateFormatter.date(from: key) else {
                            fatalError("date converting fail")
                        }
                        self.registeredSeq[date] = value
                    }
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    private func httpPost(_ url: String, _ body: Parameters) {
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default)
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
    
    private func authHeader() -> HTTPHeaders{
        guard let loginUser = authManager.loginUser else {
            return []
        }
        return [
            .authorization(bearerToken: loginUser.token)
        ]
    }
    
    private func toPayload(_ param: Encodable) -> [String: Any]{
        let data = try! encoder.encode(param)
        let dict: [String: Any] = try! JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
        return dict
    }
}
