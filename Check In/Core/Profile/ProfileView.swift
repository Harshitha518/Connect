//
//  ProfileView.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/21/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
        
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 72, height: 72)
                            .background(.gray)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user.email)
                                .font(.footnote)
                                .foregroundStyle(.accent)
                        }
                    }
                }
                Section("General") {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundStyle(.accent)
                        Text("email:")
                        Spacer()
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                Section("Account") {
                    Button {
                        viewModel.signOut()                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "sign out", tintColor: .red)
                    }
                    
                    
                }
            }
            .scrollContentBackground(.hidden)
            .background(.bg)
            
        }
    }
}

#Preview {
    ProfileView()
        .environment(AuthViewModel())
}
