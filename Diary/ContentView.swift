//
//  ContentView.swift
//  Diary
//
//  Created by SejinJo on 2022/08/02.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    @State var date = Date()
    
    var body: some View {
        if authManager.isLogined {
            TabView {
                CalendarView()
                    .tabItem {
                        Image(systemName: "calendar")
                            .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                    }
            }
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthManager())
    }
}
