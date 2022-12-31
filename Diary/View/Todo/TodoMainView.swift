//
//  TodoMainView.swift
//  Diary
//
//  Created by 조세진 on 2022/12/25.
//

import SwiftUI

struct TodoMainView: View {
    
    @State var isAddModalOpened: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "person.badge.plus")
                    .padding([.trailing, .bottom, .top], 5)
                Image(systemName: "ellipsis")
                    .padding([.trailing, .bottom, .top], 5)
            }
            TodoListView()
            HStack {
                Button {
                    isAddModalOpened.toggle()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(maxHeight: 70)
                            .cornerRadius(15)
                            .padding(10)
                        HStack {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                                .padding(30)
                            Text("작업 추가")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                            Spacer()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isAddModalOpened) {
            if #available(iOS 16.0, *) {
                AddTodoView()
                    .presentationDetents([.fraction(0.1)])
            } else {
                AddTodoView()
            }
        }
    }
}

struct TodoMainView_Previews: PreviewProvider {
    static var previews: some View {
        TodoMainView()
    }
}
