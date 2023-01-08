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
  
  @EnvironmentObject var anythingApiClient: AnythingApiClient
  
  @EnvironmentObject var viewModel: TodoListViewModel
  
  @State var isClosedFinished: Bool = false
  
  init() {
    UITableView.appearance().backgroundColor = .clear
  }
  
  var body: some View {
    NavigationView {
      Image("paper_background")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .edgesIgnoringSafeArea(.all)
        .overlay {
          List {
            Section {
              ForEach(viewModel.todoItems, id: \.seq) { todoItem in
                if !todoItem.isCompleted {
                  TodoItemView(todoItem: todoItem)
                }
              }
            }
            .background(Color.clear)
            Section {
              if !isClosedFinished {
                ForEach(viewModel.todoItems, id: \.seq) { todoItem in
                  if todoItem.isCompleted {
                    TodoItemView(todoItem: todoItem)
                  }
                }
              }
            } header: {
              Button {
                isClosedFinished.toggle()
              } label: {
                ZStack {
                  Rectangle()
                    .fill(.blue)
                    .frame(width: 80, height: 25)
                    .cornerRadius(5)
                  HStack {
                    if isClosedFinished {
                      Image(systemName: "chevron.forward")
                        .foregroundColor(.white)
                        .font(Font.system(size: 17, weight: .heavy))
                    } else {
                      Image(systemName: "chevron.forward")
                        .foregroundColor(.white)
                        .font(Font.system(size: 17, weight: .heavy))
                        .rotationEffect(.radians(.pi * 0.5))
                    }
                    Text("완료됨")
                      .foregroundColor(.white)
                      .font(.system(size: 17, weight: .heavy))
                  }
                }
              }
            }
          }
        }
      
    }
    .frame(maxHeight: .infinity)
    .background {
      Image("paper_background").resizable()
        .ignoresSafeArea()
    }
    .task {
      await viewModel.refreshTodoItems()
    }
  }
}

struct TodoListView_Previews: PreviewProvider {
  static var previews: some View {
    TodoListView()
      .environmentObject(AnythingApiClient())
      .environmentObject(TodoListViewModel())
  }
}
