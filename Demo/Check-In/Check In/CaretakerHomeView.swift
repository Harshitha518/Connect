//
//  CaretakerHomeView.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/21/24.
//

import SwiftUI

struct CaretakerHomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
    if let user = authViewModel.currentUser {
        NavigationStack {
            VStack {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)

                                    
                
                
                
             List {
                 Section("Today") {
                     ForEach(authViewModel.allUsers) { user in
                         // Safely unwrapping the last info entry
                         let lastInfo = user.infoHistory.last
                         // Using optional binding
                         let checkedIn = lastInfo?.date == Date().startOfDay ? lastInfo?.checkedIn ?? false : false
                         let message = lastInfo?.date == Date().startOfDay ? lastInfo?.messages ?? "" : ""
                         let feeling = lastInfo?.date == Date().startOfDay ? lastInfo?.feeling ?? 3 : 3
                         if user.email != "caretaker@gmail.com" {
                             SeniorDataView(name: user.fullname, checkedIn: checkedIn, email: user.email, message: message, feeling: feeling, today: true)
                         }
                     }
                 }
                 
                /* Section("Yesterday") {
                     ForEach(authViewModel.allUsers) { user in
                         // Safely unwrapping the second to last info entry
                         let lastInfo = user.infoHistory.last
                         // Using optional binding
                         let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())?.startOfDay
                         let checkedIn = lastInfo?.date == yesterday ? lastInfo?.checkedIn ?? false : false
                         let message = lastInfo?.date == yesterday ? lastInfo?.messages ?? "" : ""
                         let feeling = lastInfo?.date == yesterday ? lastInfo?.feeling ?? 3 : 3
                         if user.email != "caretaker@gmail.com" {
                             SeniorDataView(name: user.fullname, checkedIn: checkedIn, email: user.email, message: message, feeling: feeling, today: false)
                         }
                     }
                     
                 }*/
                 
                 Section {
                     Button(action: {}, label: {
                         HStack {
                             Text("History")
                                 .foregroundStyle(.accent)
                         }
                     })
                 }


             }
             .onAppear {
                 Task {
                     
                         await authViewModel.fetchAllUsers()
                     
                         
                 }
             }
                
                      
                    
                    
                }
                    .navigationTitle("Overview")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink {
                                ProfileView()
                            } label: {
                                Image(systemName: "gear")
                            }

                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(.bg)
             
            }
        .onAppear {
            print("Caretake view appreared!")
        }
        
    }
    }
    
    
}


struct SeniorDataView: View {
    var name: String
    var checkedIn: Bool
    var email: String
    var message: String
    var feeling: Int
    var today: Bool
   
    
    var body: some View {
        HStack {
            Image(systemName: checkedIn ? "checkmark.circle.fill" : "xmark.circle.fill")
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundStyle(checkedIn ? .green : .red)
                
            Text(name)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 4)
            
            Spacer()
            
        
            if checkedIn == true {
                HStack {
                    Text("feeling  1 - 5:")
                        .multilineTextAlignment(.center)
                    Text("\(feeling)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 4)
                }
            }
            
        }
    }
}

#Preview {
    SeniorDataView(name: "Brenda Willson", checkedIn: true, email: "brenda.senior@gmail.com", message: "When is bingo night?", feeling: 4, today: true)
}
