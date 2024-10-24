//
//  LoginView.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/20/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Image("FullAppName")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                // form fields
                VStack(spacing: 24) {
                    InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                        .textInputAutocapitalization(.never)
                    
                
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
        
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //log in button
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("Log In")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width-32, height: 48)
                }
                .background(.accent)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                                
                Spacer()
                
                // sign up button
                NavigationLink {
                    SignupView().navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Don't have an account? ")
                            .foregroundStyle(.gray)
                        Text("Sign up!")
                            .fontWeight(.bold)
                            .foregroundStyle(.accent)
                    }
                }

            }
            .background(.bg)
        }
       
        
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}


#Preview {
    LoginView()
        .environment(AuthViewModel())
}
