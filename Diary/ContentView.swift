//
//  ContentView.swift
//  Diary
//
//  Created by SejinJo on 2022/08/02.
//

import SwiftUI

struct ContentView: View {
    
    @State var date = Date()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "1.circle")
                }
            CalendarView(start: Date(), monthsToShow: 1)
                .tabItem {
                    Image(systemName: "2.circle")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
