//
//  TodoItem.swift
//  Diary
//
//  Created by 조세진 on 2022/12/25.
//

import Foundation

class TodoItem: Codable, ObservableObject {
    
    var seq: Int64
    
    var contents: String
    
    @Published var isCompleted: Bool
    
    @Published var isStarred: Bool

    var startedAt: Date

    var endedAt: Date

    var numberOfOrder: Int
    
    init(seq: Int64, contents: String, isCompleted: Bool, isStarred: Bool, startedAt: Date, endedAt: Date, numberOfOrder: Int) {
        self.seq = seq
        self.contents = contents
        self.isCompleted = isCompleted
        self.isStarred = isStarred
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.numberOfOrder = numberOfOrder
    }
}

private class PublishedWrapper<T> {
    @Published private(set) var value: T

    init(_ value: Published<T>) {
        _value = value
    }
}

extension Published {
    var unofficialValue: Value {
        PublishedWrapper(self).value
    }
}

extension Published: Decodable where Value: Decodable {
    public init(from decoder: Decoder) throws {
        self.init(wrappedValue: try .init(from: decoder))
    }
}

extension Published: Encodable where Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        try unofficialValue.encode(to: encoder)
    }
}
