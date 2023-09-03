//
//  LoginView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isError = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    // Simulate signup success for demonstration purposes
                    Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                        if let error = error {
                            // Handle the error (e.g., display an error message)
                            isError=true
                            print("Error signing in: \(error.localizedDescription)")
                        } else if let user = authResult?.user {
                            // User signed in successfully
                            print("User signed in: \(user.uid)")
                        }
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                if isError {
                    Text("Sign-up successful!\nEmail: \(email)\nPassword: \(password)")
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.green)
                    
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
