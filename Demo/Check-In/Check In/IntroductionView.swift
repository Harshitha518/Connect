//
//  IntroductionView.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/20/24.
//

import SwiftUI

struct IntroductionView: View {
    @State private var userName = ""
    @State private var homeLocation = ""
    @State private var timeForCheckIn = ""
    
    @State private var nameOfCareTaker = ""
    @State private var phoneOfCareTaker = ""
    
    var body: some View {
        NavigationStack {
            List {
                Text("Welcome to check in! This app will allow your loved ones to have a peace of mind about your safety!")
                
                Section("Let's get to know you:") {
                    TextField("What's your name?", text: $userName)
                    TextField("Where do you live?", text: $homeLocation)
                    TextField("Set a time for you to check in everyday", text: $homeLocation)
                }
                
                Section("Let's get to know your care taker!") {
                    TextField("What's their name?", text: $nameOfCareTaker)
                    TextField("What's their phone number?", text: $phoneOfCareTaker)
                }
            }
            .navigationTitle("Nice to meet you!")
        }
    }
}




#Preview {
    IntroductionView()
}


