//
//  Info.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/13/24.
//

import Foundation
import SwiftUI

struct Info: Identifiable, Hashable, Codable {
    var id = UUID()
    
    let checkedIn: Bool
    let date: Date
    let feeling: Int
    let messages: String
    
    
}

@Observable
class History: ObservableObject {
    
    
    var infoHistory = [Info]()  /*{
                                 didSet {
                                 let encoder = JSONEncoder()
                                 if let encoded = try? encoder.encode(infoHistory) {
                                 UserDefaults.standard.set(encoded, forKey: "Info")
                                 }
                                 }
                                 }
                                 
                                 init() {
                                 if let savedInfoHistory = UserDefaults.standard.data(forKey: "Info") {
                                 if let decodedInfoHistory = try? JSONDecoder().decode([Info].self, from: savedInfoHistory) {
                                 infoHistory = decodedInfoHistory
                                 return
                                 }
                                 }
                                 
                                 
                                 
                                 infoHistory = []
                                 
             } */
    
}

