//
//  Check_InApp.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/13/24.
//

import SwiftUI
import Firebase

@main
struct Check_InApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .environment(viewModel)
               
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
