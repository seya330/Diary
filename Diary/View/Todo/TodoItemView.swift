//
//  TodoItem.swift
//  Diary
//
//  Created by 조세진 on 2022/12/02.
//

import SwiftUI

struct TodoItemView: View {
    
    @State var isCompleted: Bool = false
    
    @State var isStarred: Bool = false
    
    var todoItem: TodoItem
    
    var body: some View {
        NavigationLink {
            Text("")
        } label: {
            HStack {
                ZStack {
                    if isCompleted {
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
                    isCompleted.toggle()
                }
                .animation(.easeInOut, value: isCompleted)
                .padding(10)
                
                Text(todoItem.contents)
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack {
                    if isStarred {
                        Image(systemName: "star.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                    } else {
                        Image(systemName: "star")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    }
                }
                .onTapGesture {
                    isStarred.toggle()
                }
                .animation(.easeInOut, value: isStarred)
                .padding(10)
                
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
        }
        }

        
}

struct TodoItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemView(todoItem: TodoItem(seq: 1, contents: "장보기", status: .ADDED, isStarred: false, startedAt: Date(), endedAt: Date(), numberOfOrder: 1))
    }
}
