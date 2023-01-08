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
          }
        TodoMainView()
          .environmentObject(TodoListViewModel())
          .environmentObject(TodoUIViewModel())
          .tabItem {
            Image(systemName: "checkmark")
          }
      }
      .tint(Color(red: 242/255, green: 163/255, blue: 27/255, opacity: 1.0))
    } else {
      LoginView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let authManager = AuthManager()
    authManager.loginUser = User(token: "Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJhbnl0aGluZy5jb20iLCJzdWIiOiIyIiwiYXVkIjoiIiwiZXhwIjo5MjIzMzcyMDM2ODU0Nzc1LCJuYmYiOjE2NzIwNjcxNTcsImlhdCI6MTY3MjA2NzE1N30.J14T7bNaqLW94Gq4wrG5QVxHKXpx5ZOecVhkJQdSSoKNcMHMA1FqX-SGffF2XC7i0_9_KTfafWLEtJfgBTuusQ", email: "seya3302@gmail.com", name: "seya3302")
    authManager.isLogined = true
    return ContentView().environmentObject(authManager)
  }
}
