//
//  DiaryListView2.swift
//  Diary
//
//  Created by 조세진 on 2022/11/22.
//

import SwiftUI

struct DiaryListView: View {
    var body: some View {
        VStack {
            ScrollView {
                DiaryListViewItem()
                DiaryListViewItem()
                DiaryListViewItem()
                DiaryListViewItem()
                DiaryListViewItem()
                DiaryListViewItem()
                DiaryListViewItem()
                DiaryListViewItem()
                DiaryListViewItem()
                DiaryListViewItem()
            }
        }.background {
            Image("paper_background").resizable()
                .ignoresSafeArea()
        }
    }
}

struct DiaryListView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView()
    }
}

struct DiaryListViewItem: View {
    var body: some View {
        VStack {
            HStack {
                Line()
                Line()
                Line()
                Line()
                Line()
                Text("2022-11-22")
                    .font(Font.custom("ACCchildrenheart", size: 22))
                    .foregroundColor(Color(red: 242/255, green: 163/255, blue: 27/255, opacity: 1))
                    .frame(width: 120)
                Line()
            }
            Section {
                    Text("asdadsfasdfzxcvzxcvzxcv]nasdfasdf\nadsfasdfcxvzzzz")
                        .font(Font.custom("ACCchildrenheart", size: 22))
                        .foregroundColor(.black.opacity(0.7))
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.clear)
        }
        .padding([.top], 20)
    }
}
