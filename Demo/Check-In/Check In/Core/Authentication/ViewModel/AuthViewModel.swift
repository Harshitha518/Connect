//
//  AuthViewModel.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/21/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreCombineSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}


// AuthViewModel responsible for: having all funcs related with authenticating user and sending notifications to UI when it needs to be updated
// observableObject protocol --> view able to observe changes in view mode
// Publishes UI to main thread
@MainActor
class AuthViewModel: ObservableObject, Observable {
    // Tracks whether or not the user is logged in
    @Published var userSession: FirebaseAuth.User?
    // Our user
    @Published var currentUser: User?
    
    @Published var allUsers: [User] = []
    
    @Published var allUsersId: [User.ID] = []
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("THERE WAS AN ERROR! \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String, caretakerPhone: String, infoHistory: [Info]) async throws {
        do {
            // Creating user
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email, caretakerPhone: caretakerPhone, infoHistory: infoHistory)
            let encodedUser = try Firestore.Encoder().encode(user)
            // uploading to firebase
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            // Need to fetch data so its displayed
            await fetchUser()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            // signs out user on back end
            try Auth.auth().signOut()
            // Wipes out user session + takes user back to login screen
            self.userSession = nil
            // Wipes out current user data model
            self.currentUser = nil
        } catch {
            print("\(error.localizedDescription)")
        }
        
    }
    
    func deleteAccount() {
        print("Deleting account...")
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func addInfo(checkedIn: Bool, date: Date, feeling: Int, messages: String) {
        let newInfo = Info(checkedIn: checkedIn, date: date, feeling: feeling, messages: messages)
        currentUser?.infoHistory.append(newInfo)
        
        // Save to firebase
        saveInfohistoryToDB(currentUser!)
    }
    
    func saveInfohistoryToDB(_ user: User) {
        let userRef = Firestore.firestore().collection("users").document(user.id)
        
        do {
            // Convert user to data
            let userData = try Firestore.Encoder().encode(user)
            
            // Set data in Firestore
            userRef.setData(userData) { error in
                if let error = error {
                    print("Error saving user info: \(error.localizedDescription)")
                } else {
                    print("Sucessfully saved")
                }
            }
            
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func fetchAllUsers() async {
        do {
                let snapshot = try await Firestore.firestore().collection("users").getDocuments()
                
                var users: [User] = []
                var userIds: [User.ID] = []

                for document in snapshot.documents {
                    if let user = try? document.data(as: User.self) {
                        users.append(user)
                        userIds.append(user.id)
                    }
                }
                
                self.allUsers = users // Store the fetched users
                print("Fetched users: \(users)") // Debug log
            } catch {
                print("Error fetching users: \(error.localizedDescription)")
            }

    }

}
