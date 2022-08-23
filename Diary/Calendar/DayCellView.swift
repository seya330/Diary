import SwiftUI

struct DayCellView: View {
    
    @ObservedObject var day: Day
    
    let isWritedDiary: Bool
    
    var body: some View {
        VStack {
            Text(day.dayName).frame(width: 32, height: 32)
                .foregroundColor(day.textColor)
                .background(day.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
        }
        .background(day.backgroundColor)
        .if(isWritedDiary, content: { content in
            content.overlay(Circle().stroke(Color.red, lineWidth: 2))
        })
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        DayCellView(day: Day(date: Date()), isWritedDiary: true)
    }
}

extension View {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}
