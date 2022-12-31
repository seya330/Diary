//
//  TodoListViewModel.swift
//  Diary
//
//  Created by 조세진 on 2022/12/31.
//

import Foundation

class TodoListViewModel: ObservableObject {
    
    @Published var todoItems: [TodoItem] = []
}
