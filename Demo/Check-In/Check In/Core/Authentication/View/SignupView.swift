//
//  SignupView.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/20/24.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    //@EnvironmentObject var history: History
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    //@State private var showingMessages = false
    @State private var caretakerPhone = ""
    
    @Environment(\.dismiss) var dismiss
    
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
                    
                    InputView(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                    
                    ZStack(alignment: .trailing) {
                        
                        InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Re-enter your password", isSecureField: true)
                        
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.green)
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.red)

                            }
                        }
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //sign up button
                Button {
                    Task {
                        try await viewModel.createUser(withEmail: email, password: password, fullname: fullname, caretakerPhone: caretakerPhone, infoHistory: History().infoHistory)
                    }
                } label: {
                    HStack {
                        Text("Sign Up")
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
                
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Already have an account? ")
                            .foregroundStyle(.gray)
                        Text("Log In!")
                            .fontWeight(.bold)
                            .foregroundStyle(.accent)
                    }
                }
            }
            .background(.bg)
        }
       
    }
}

extension SignupView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}


#Preview {
    SignupView()
        .environment(AuthViewModel())
        //.environment(History())
}
