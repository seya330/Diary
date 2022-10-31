import SwiftUI
struct MultiTextField: UIViewRepresentable {
    
    @EnvironmentObject var obj: observed
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.font = .systemFont(ofSize: 19)
        view.text = "Type Something"
        view.textColor = UIColor.black.withAlphaComponent(0.35)
        view.backgroundColor = .yellow
        view.delegate = context.coordinator
        self.obj.size = view.contentSize.height
        view.isEditable = true
        view.isUserInteractionEnabled = true
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return MultiTextField.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: MultiTextField
        
        init(parent: MultiTextField) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
//            self.parent.obj.size = textView.contentSize.height < 300 ? textView.contentSize.height : 300
            self.parent.obj.size = textView.contentSize.height
        }
    }
}

class observed: ObservableObject {
    
    @Published var size: CGFloat = 0
}
