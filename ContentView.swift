import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = false
    
    var body: some View {
        Group {
            if showOnboarding {
                OnboardingView()
            } else {
                SplashView(showOnboarding: $showOnboarding)
            }
        }
    }
}

struct SplashView: View {
    @Binding var showOnboarding: Bool
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.3).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Welcome to")
                    .font(.title)
                    .foregroundColor(.white)
                Text("Eternal Call")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "sparkle")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    showOnboarding = true
                }
            }
        }
    }
}

struct OnboardingView: View {
    @State private var showSignUp = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.05, green: 0.05, blue: 0.15).edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Spacer()
                    Text("Voices from the past,")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                    Text("always")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                    Text("within reach")
                        .foregroundColor(.white)
                        .font(.system(size: 32, weight: .bold))
                    Spacer()
                    HStack(spacing: 20) {
                        SocialLoginButton(imageName: "Facebook")
                        SocialLoginButton(imageName: "Google")
                        SocialLoginButton(imageName: "Apple")
                    }
                    Text("OR")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        .padding(.vertical, 10)
                    Button(action: {
                        showSignUp = true
                    }) {
                        Text("Sign up with email")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 20)
                    Button(action: {
                        // Implement login logic
                        print("Log in")
                    }) {
                        Text("Existing account? Log in")
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showSignUp) {
                SignUpView()
            }
        }
    }
}

struct SocialLoginButton: View {
    let imageName: String
    
    var body: some View {
        Button(action: {
            print("\(imageName) login")
        }) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        }
    }
}

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.15).edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    // Implement sign up logic here
                    print("Signing up with email: \(email)")
                }) {
                    Text("Sign Up")
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Back")
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
