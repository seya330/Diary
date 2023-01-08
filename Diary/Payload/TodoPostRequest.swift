//
//  TodoPostRequest.swift
//  Diary
//
//  Created by 조세진 on 2022/12/31.
//

import Foundation

struct TodoPostRequest: Encodable {
  
  let contents: String
  
  let isCompleted: Bool
  
  let isStarred: Bool
  
  let startedAt: Date?
  
  let endedAt: Date?
}
