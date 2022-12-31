//
//  TodoListView.swift
//  Diary
//
//  Created by 조세진 on 2022/12/02.
//

import SwiftUI
import Alamofire
import Combine

struct TodoListView: View {
    
    @State var todoItems: [TodoItem] = []
    
    @ObservedObject var viewModel = TodoListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section("Section 1") {
                    ForEach(viewModel.todoItems, id: \.seq) { todoItem in
                        if !todoItem.isCompleted {
                            TodoItemView(todoItem: todoItem)
                                .environmentObject(viewModel)
                        }
                    }
                }
                Section {
                    ForEach(viewModel.todoItems, id: \.seq) { todoItem in
                        if todoItem.isCompleted {
                            TodoItemView(todoItem: todoItem)
                                .environmentObject(viewModel)
                        }
                    }
                } header: {
                    Button {
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(.blue)
                                .frame(width: 80, height: 25)
                                .cornerRadius(5)
                            HStack {
                                Image(systemName: "greaterthan")
                                    .foregroundColor(.white)
                                    .rotationEffect(.radians(.pi * 0.5))
                                Text("완료됨")
                                    .foregroundColor(.white)
                            }
                            
                        }
                    }
                    
                }
                
            }
        }
        .frame(maxHeight: .infinity)
        .task {
            guard let loginUser = authManager.loginUser else {
                return
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            AF.request(DiaryConfig.baseUrl + "/api/todos", method: .get, parameters: [
                "page": 0,
                "size": 10
            ], encoding: URLEncoding.default, headers: [.authorization(bearerToken: loginUser.token)])
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PageResult<TodoItem>.self, decoder: decoder) { response in
                switch(response.result) {
                case .success(let pageResult):
                    todoItems.removeAll()
                    for todoItem in pageResult.content {
                        todoItems.append(todoItem)
                    }
                    viewModel.todoItems = pageResult.content
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
