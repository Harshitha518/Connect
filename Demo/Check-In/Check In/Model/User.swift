//
//  User.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/21/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let caretakerPhone: String
    var infoHistory: [Info]
   
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return "User"
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Kobe Bryant", email: "test@gmail.com", caretakerPhone: "908-800-8910", infoHistory: [Info(checkedIn: true, date: Date().startOfDay, feeling: 4, messages: "Hello!"), Info(checkedIn: true, date: Date().startOfMonth, feeling: 3, messages: "Hi!")])
}
