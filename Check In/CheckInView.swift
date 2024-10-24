//
//  CheckInView.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/13/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

struct CheckInView: View {
    //@EnvironmentObject var information: History
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var checkedInToday = false
    @State private var date = Date().startOfDay
    @State private var feeling = 3
    @State private var message = ""
   
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(date.formatted(date: .abbreviated, time: .omitted))
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                                    
                Spacer()
                
                VStack {
                    Text("How are you feeling today?")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Picker("", selection: $feeling, content: {
                        ForEach(0..<6, content: {number in
                            if number == 0 {
                                
                            } else {
                                Text("\(number)")
                            }
                        })
                    })
                    .pickerStyle(.segmented)
                    .disabled(checkedInToday == true ? true : false)
                    HStack {
                        Image(systemName: "hand.thumbsdown.fill")
                            .font(.title)
                        Spacer()
                        Image(systemName: "hand.thumbsup.fill")
                            .font(.title)
                        
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
                
                VStack {
                    Text("Message:")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("What would like to let your caretaker know?", text: $message)
                        .textFieldStyle(.roundedBorder)
                        .disabled(checkedInToday == true ? true : false)
                }
                .padding(.vertical)

                
                Spacer()
                
                Button(action: {
                    checkedInToday = true
                    date = Date().startOfDay
                    
                   // let newHistoryEntry = Info(checkedIn: checkedInToday, date: date, feeling: feeling, messages: message)
                    //authViewModel.currentUser.infoHistory.append(newHistoryEntry)
                  // authViewModel.currentUser?.infoHistory.append(Info(checkedIn: checkedInToday, date: date, feeling: feeling, messages: message))
                    //var user1 = authViewModel.currentUser
                    authViewModel.addInfo(checkedIn: checkedInToday, date: date, feeling: feeling, messages: message)
                    
                    //let encodedUser = try Firestore.Encoder().encode(authViewModel.currentUser)
                    //try await Firestore.firestore().collection("users").document(encodedUser.updateValue((authViewModel.currentUser?.infoHistory)
                    /* let userRef = Firestore.firestore().collection("users").document(authViewModel.currentUser?.id)
                    let historyData = authViewModel.currentUser.map { [ "checkedIn": $0.checkedInToday, "date": $0.date, "feeling": $0.feeling, "messages": $0.message ]
                        
                    }
                    
                    userRef.setData(["infoHistory": historyData], merge: true) { error in
                        if let error = error {
                            print("Error writing doc: \(error.localizedDescription)")
                        } else {
                            print("Sucessful")
                        }
                       */
                   // }
                    
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundStyle(checkedInToday ? .green : .red)
                            .frame(width: 375, height: 100)
                        Text(checkedInToday ? "Checked in!" : "Check in please!")
                            .foregroundStyle(.white)
                            .font(.headline)
                    }
                })
                
                Spacer()
            }
            .navigationTitle("Check In")
            .padding()
            .background(.bg)
        }
    }
}

#Preview {
    CheckInView()
}

