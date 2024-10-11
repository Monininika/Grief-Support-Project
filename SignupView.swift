import SwiftUI

struct SignupView: View {
    @State private var showPersonalizationOption = false
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.15).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Create Account") {
                    showPersonalizationOption = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showPersonalizationOption) {
            PersonalizationOptionView()
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}