//
//  Line.swift
//  Diary
//
//  Created by 조세진 on 2022/11/22.
//

import SwiftUI

struct Line: View {
    var body: some View {
        VStack {
            Divider()
                .frame(height: 4)
                .overlay(Color(red: 242/255, green: 163/255, blue: 27/255, opacity: 0.2))
                .padding([.leading, .trailing], -4)
        }
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Line()
    }
}
