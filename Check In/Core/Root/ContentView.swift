//
//  ContentView.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/20/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
        
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                if viewModel.currentUser?.email == "caretaker@gmail.com" {
                    CaretakerHomeView()
                } else {
                    SeniorHomeView()
                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthViewModel())
}
