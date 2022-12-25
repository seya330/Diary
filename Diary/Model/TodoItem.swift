//
//  TodoItem.swift
//  Diary
//
//  Created by 조세진 on 2022/12/25.
//

import Foundation

class TodoItem: Decodable, ObservableObject {
    
    var seq: Int64
    
    var contents: String
    
    var status: TodoItemStatus
    
    var isStarred: Bool

    var startedAt: Date

    var endedAt: Date

    var numberOfOrder: Int
    
    init(seq: Int64, contents: String, status: TodoItemStatus, isStarred: Bool, startedAt: Date, endedAt: Date, numberOfOrder: Int) {
        self.seq = seq
        self.contents = contents
        self.status = status
        self.isStarred = isStarred
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.numberOfOrder = numberOfOrder
    }
}

enum TodoItemStatus: String, Decodable {
    case ADDED
    case COMPLETED
}
