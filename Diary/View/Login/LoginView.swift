import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Image("paper_background")
                        .resizable()
                        .aspectRatio(geometry.size, contentMode: .fill)
                        .ignoresSafeArea()
                    VStack {
                        Text("나의 일기장")
                            .font(Font.custom("ACCchildrenheart", size: 40))
                            .foregroundColor(.gray)
                        GoogleSignInButton(style: .icon) {
                            authManager.googleLogin()
                        }
                        .padding([.leading, .trailing])
                    }
                }
            }
        }
        .frame(width: .infinity, height: .infinity)
        .onOpenURL { url in
            GIDSignIn.sharedInstance.handle(url)
        }
        .onAppear {
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                guard error == nil else {return}
                guard let user else {return}
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthManager())
    }
}
