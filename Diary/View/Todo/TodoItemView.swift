//
//  TodoItem.swift
//  Diary
//
//  Created by 조세진 on 2022/12/02.
//

import SwiftUI

struct TodoItemView: View {
    
    @EnvironmentObject var anythingApiClient: AnythingApiClient
    
    @EnvironmentObject var parentViewModel: TodoListViewModel
    
    @ObservedObject var todoItem: TodoItem
    
    var body: some View {
        NavigationLink {
            Text("미구현 입니다....")
        } label: {
            HStack {
                ZStack {
                    if todoItem.isCompleted {
                        Circle()
                            .fill(.blue)
                            .frame(width: 25, height: 25)
                        Image(systemName: "checkmark")
                            .font(.system(size: 11, weight: .black))
                            .foregroundColor(.white)
                        
                    } else {
                        Circle()
                            .fill(.gray)
                            .frame(width: 25, height: 25)
                        Circle()
                            .fill(.white)
                            .frame(width: 20, height: 20)
                    }
                }
                .onTapGesture {
                    Task {
                        if (await anythingApiClient.modifyCompleted(seq:todoItem.seq, isCompleted:!todoItem.isCompleted) ) {
                            todoItem.isCompleted.toggle()
                            parentViewModel.objectWillChange.send()
                        }
                    }
                    
                }
                .animation(.easeInOut, value: todoItem.isCompleted)
                .padding(10)
                
                Text(todoItem.contents)
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack {
                    if todoItem.isStarred {
                        Image(systemName: "star.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                    } else {
                        Image(systemName: "star")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    }
                }
                .animation(.easeInOut, value: todoItem.isStarred)
                .padding(10)
                .onTapGesture {
                    Task {
                        if await anythingApiClient.modifyStarred(seq: todoItem.seq, isStarred: !todoItem.isStarred) {
                            todoItem.isStarred.toggle()
                            parentViewModel.objectWillChange.send()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
        }
        .task {
            print("todoItem")
            print(Unmanaged.passUnretained(todoItem).toOpaque())
        }
    }
}

struct TodoItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemView(todoItem: TodoItem(seq: 1, contents: "장보기", isCompleted: false, isStarred: false, startedAt: Date(), endedAt: Date(), numberOfOrder: 1))
            .environmentObject(AnythingApiClient())
    }
}
