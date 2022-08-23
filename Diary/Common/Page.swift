import Foundation

struct PageResult<T: Decodable>: Decodable{
    var content: [T]
    var pageable: Pageable?
    var totalPages: Int?
    var totalElements: Int?
    var first: Bool?
    var last: Bool?
    var numberOfElements: Int?
    var size: Int?
    var number: Int?
    var empty: Bool?
}

struct Pageable: Codable {
    var pageNumber: Int?
    var pageSize: Int?
    var offset: Int?
}
