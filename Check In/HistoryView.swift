//
//  SeniorDataView.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/13/24.
//

import SwiftUI

struct SeniorHomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
    if var user = viewModel.currentUser {
        NavigationStack {
            VStack {
                Spacer()
                if !user.infoHistory.isEmpty {
                    NavigationLink(destination: {
                        CheckInView()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20.0)
                                .frame(height: 50)
                            if user.infoHistory.last!.date == Date().startOfDay {
                                Text(user.infoHistory.last!.checkedIn == true ? "You've already Checked in" : "Check in for today!")
                                    .foregroundStyle(.white)
                            } else {
                                Text("Check in for today!")
                                    .foregroundStyle(.white)
                            }
                        }
                    })
                    .disabled(user.infoHistory.last!.date == Date().startOfDay ? true : false)
                    .padding()
                } else {
                    NavigationLink(destination: {
                        CheckInView()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20.0)
                                .frame(height: 50)
                            Text("Check in for today!")
                                .foregroundStyle(.white)
                            
                        }
                        
                    })
                    .padding()
                }
                
            
                
                CalendarView()
                Spacer()
                
            }
            .scrollContentBackground(.hidden)
            .background(.bg)
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        Image(systemName: "gear")
                    }

                }
            }
            
            
        }
        }
    }
}

#Preview {
    SeniorDataView(name: "", checkedIn: true, email: "", message: "", feeling: 4, today: false)
        .environmentObject(AuthViewModel())
}
