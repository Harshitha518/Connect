//
//  SettingsRowView.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/21/24.
//

import SwiftUI

struct SettingsRowView: View {
    @EnvironmentObject var history: History
    
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundStyle(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "Version", tintColor: .accent)
}
