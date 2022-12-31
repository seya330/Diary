//
//  AddTodoView.swift
//  Diary
//
//  Created by 조세진 on 2022/12/26.
//

import SwiftUI

struct AddTodoView: View {
    
    @State private var contents: String = ""
    
    @FocusState private var focused: Bool
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(.gray)
                        .frame(width: 25, height: 25)
                    Circle()
                        .fill(.white)
                        .frame(width: 20, height: 20)
                }
                .padding()
                TextField("작업 추가", text: $contents)
                    .focused($focused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            focused = true
                        }
                    }
            }
            HStack {
                Image(systemName: "sun.min")
                    .padding([.leading, .trailing])
                Spacer()
            }
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
