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
  
  var body: some View {
    NavigationView {
      if #available(iOS 16.0, *) {
        List {
          Section {
            ForEach(viewModel.todoItems, id: \.seq) { todoItem in
              if !todoItem.isCompleted {
                TodoItemView(todoItem: todoItem)
              }
            }
          }
          .listRowBackground(Color.clear)
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
        .scrollContentBackground(.hidden)
        .background(content: {
            Image("paper_background").resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
        })
      } else {
        Text("ios 버전을 최신 버전으로 업데이트 해 주세요.")
      }
    }
    .frame(maxHeight: .infinity)
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
