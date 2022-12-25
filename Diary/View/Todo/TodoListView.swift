//
//  TodoListView.swift
//  Diary
//
//  Created by 조세진 on 2022/12/02.
//

import SwiftUI
import Alamofire

struct TodoListView: View {
    
    @State var todoItems: [TodoItem] = []
    
    var body: some View {
        NavigationView {
            List {
                Section("Section 1") {
                    ForEach(todoItems, id: \.seq) { todoItem in
                        if todoItem.status == .ADDED {
                            TodoItemView(todoItem: todoItem)
                        }
                    }
                }
                Section {
                    ForEach(todoItems, id: \.seq) { todoItem in
                        if todoItem.status == .COMPLETED {
                            TodoItemView(todoItem: todoItem)
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            AF.request(DiaryConfig.baseUrl + "/api/todos", method: .get, parameters: [
                "page": 0,
                "size": 10
            ], encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PageResult<TodoItem>.self, decoder: decoder) { response in
                switch(response.result) {
                case .success(let pageResult):
                    todoItems.removeAll()
                    for todoItem in pageResult.content {
                        todoItems.append(todoItem)
                    }
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
