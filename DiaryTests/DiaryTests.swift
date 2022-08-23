//
//  DiaryTests.swift
//  DiaryTests
//
//  Created by SejinJo on 2022/08/02.
//

import XCTest
@testable import Diary

class DiaryTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testExample() throws {
        let decoder: JSONDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let str: String =
        """
        {
            "registeredAt": "2022-07-30T15:41:20.001",
            "updatedAt": "2022-07-30T15:41:26.001",
            "seq": 1,
            "content": "asdfㅁㅁㅁㅁ"
        }
        """
        let json = str.data(using: .utf8)
        let diary: DiaryDecodable = try decoder.decode(DiaryDecodable.self, from: json!)
        
        print(diary)
    }
    
    func testDiariesDecode() throws {
        let decoder: JSONDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let str: String =
        """
        {
            "content": [
                {
                    "registeredAt": "2022-07-30T15:41:20.001",
                    "updatedAt": "2022-07-30T15:41:26.001",
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
                    "registeredAt": "2022-07-30T15:05:36.515",
                    "updatedAt": "2022-07-30T15:05:36.515",
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
        
        let json = str.data(using: .utf8)
        let diaries = try decoder.decode(PageResult<DiaryDecodable>.self, from: json!)
        print(diaries)
    }
    
    func testDateDescription() throws {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date: Date = DateFactory.of(year: 2022, month: 8, day: 5, hour: 12, minute: 15, second: 1)
    }
    
    func testDateComponents() throws {
        let month: Month = Month(startDate: Date(), selectableDays: true)
        let month2: Month2 = Month2(startDate: Date(), selectableDays: true)
        let monthday = month.monthDays
        let monthday2 = month2.monthDays
        print(1)
//        print(month.monthDays[4+1]![4])
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
