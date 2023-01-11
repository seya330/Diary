//
//  DiaryTests.swift
//  DiaryTests
//
//  Created by SejinJo on 2022/08/02.
//

import XCTest
import Alamofire
@testable import Diary

class DiaryTests: XCTestCase {
  
  let str: String =
  """
  {
      "content": [
          {
              "registeredAt": "2022-07-30T15:41:20",
              "updatedAt": "2022-07-30T15:41:26",
              "seq": 1,
              "content": "asdfㅁㅁㅁㅁ"
          },
          {
              "registeredAt": "2022-07-30T15:41:24.001",
              "updatedAt": "2022-07-30T15:41:27.001",
              "seq": 2,
              "content": "asdfㅁㅁㅁㅁzzzzzz"
          },
          {
              "registeredAt": "2022-07-13T19:51:54.071",
              "updatedAt": "2022-07-13T19:51:54.071",
              "seq": 3,
              "content": "asdfㅁㅁㅁㅁzzzzzzㄴㄴㄴㄴ"
          },
          {
              "registeredAt": "2022-07-13T19:52:51.439",
              "updatedAt": "2022-07-13T19:52:51.439",
              "seq": 4,
              "content": "asdfㅁㅁㅁㅁzzzzzzㄴㄴㄴㄴ"
          },
          {
              "registeredAt": "2022-07-14T00:17:42.806",
              "updatedAt": "2022-07-14T00:17:42.806",
              "seq": 5,
              "content": "iOS testtest"
          },
          {
              "registeredAt": "2022-07-28T09:52:01.888",
              "updatedAt": "2022-07-28T09:52:01.888",
              "seq": 6,
              "content": "Add gasdfzxcvzxcvasdf"
          },
          {
              "registeredAt": "2022-07-29T00:15:17.949",
              "updatedAt": "2022-07-29T00:15:17.949",
              "seq": 7,
              "content": "Asdasdasdasd"
          },
          {
              "registeredAt": "2022-07-29T21:00:50.874",
              "updatedAt": "2022-07-29T21:00:50.874",
              "seq": 8,
              "content": "Asdasdasdz"
          },
          {
              "registeredAt": "2022-07-30T15:05:36.515111",
              "updatedAt": "2022-07-30T15:05:36.515111",
              "seq": 9,
              "content": "20220730 iOS test"
          }
      ],
      "pageable": {
          "sort": {
              "sorted": false,
              "unsorted": true,
              "empty": true
          },
          "pageNumber": 0,
          "pageSize": 10,
          "offset": 0,
          "paged": true,
          "unpaged": false
      },
      "last": true,
      "totalPages": 1,
      "totalElements": 9,
      "first": true,
      "sort": {
          "sorted": false,
          "unsorted": true,
          "empty": true
      },
      "numberOfElements": 9,
      "size": 10,
      "number": 0,
      "empty": false
  }
  """
  
  func testDiariesDecode() throws {
    
    let iso8601Formatter = ISO8601DateFormatter()
    iso8601Formatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime]
    print(iso8601Formatter.string(from: Date()))
    
    let iso8601WithFractionalFormatter = ISO8601DateFormatter()
    iso8601WithFractionalFormatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime, .withFractionalSeconds]
    print(iso8601WithFractionalFormatter.string(from: Date()))
    
    let iso8601WithFractional6Formatter = DateFormatter()
    iso8601WithFractional6Formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    print(iso8601WithFractional6Formatter.string(from: Date()))
    
    let asdf = iso8601Formatter.date(from: "2023-01-01T00:00:01.012345")
    print(asdf)
    
    
    let decoder: JSONDecoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom({ decoder in
      let container = try decoder.singleValueContainer()
      let dateStr = try container.decode(String.self)
      guard let decoded = iso8601Formatter.date(from: dateStr) else {
        print("asdasdasdasdasd")
        return Date()
      }
      return decoded
    })
    let json = str.data(using: .utf8)
    let diaries = try decoder.decode(PageResult<DiaryDecodable>.self, from: json!)
    print(diaries)
    
    let encoder: JSONEncoder = JSONEncoder()
    encoder.dateEncodingStrategy = .formatted(<#T##DateFormatter#>)
    
  }
  
  func testDateDescription() throws {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    let date: Date = DateFactory.of(year: 2022, month: 8, day: 5, hour: 12, minute: 15, second: 1)
  }
}
