import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    var body: some View {
        VStack {
            //            FullBackground(imageName: "paper_background")
            GeometryReader { geometry in
                ZStack {
                    Image("paper_background")
                        .resizable()
                        .aspectRatio(geometry.size, contentMode: .fill)
                        .ignoresSafeArea()
                    VStack {
                        Image(systemName: "pencil.circle").font(.largeTitle)
                        GoogleSignInButton(style: .wide) {
                            AuthManager.googleLogin()
                        }
                        .padding([.leading, .trailing])
                        Button {
                            GIDSignIn.sharedInstance.signOut()
                        } label: {
                            Image(systemName: "pencil")
                        }

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
                
                let email = user.profile?.email
                let fullName = user.profile?.name
                let givenName = user.profile?.givenName
                let familyName = user.profile?.familyName
                
                let profilePicUrl = user.profile?.imageURL(withDimension: 320)
                
                print(email)
                print(fullName)
                print(givenName)
                print(familyName)
                print(profilePicUrl)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
