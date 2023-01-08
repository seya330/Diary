//
//  TodoListViewModel.swift
//  Diary
//
//  Created by 조세진 on 2022/12/31.
//

import Foundation

class TodoListViewModel: ObservableObject {
  
  @Published var todoItems: [TodoItem] = []
  
  private let anythingApiClient = AnythingApiClient()
  
  func refreshTodoItems() async {
    let resultTodoItem = await anythingApiClient.getTodos().content
    DispatchQueue.main.async {
      self.todoItems = resultTodoItem
    }
  }
  
  func addTodo(contents: String) async {
    await anythingApiClient.postTodo(todoPostRequest: TodoPostRequest(contents: contents, isCompleted: false, isStarred: false, startedAt: Date(), endedAt: Date()))
  }
}
