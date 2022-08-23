//
//  Colors.swift
//  MyDiary
//
//  Created by SejinJo on 2022/07/09.
//

import Foundation
import SwiftUI

class Colors: ObservableObject {

    //Foreground
    @Published var textColor: Color = Color.primary
    @Published var todayColor: Color = Color.blue
    @Published var disabledColor: Color = Color.gray
    @Published var selectedColor: Color = Color.primary

    //Background
    @Published var backgroundColor: Color = Color.clear
    @Published var weekdayBackgroundColor: Color = Color.clear
    @Published var selectedBackgroundColor: Color = Color.orange

}
