//
//  AuthViewModel.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 4/26/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocal{
    var formIsValid: Bool{get}
}

@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            throw error
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    static func resetPassword(email: String, resetcompletion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                resetcompletion(.failure(error))
            } else {
                resetcompletion(.success(true))
            }
        }
    )}
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    

    func deleteAccount(completion: @escaping (Error?) -> Void) {
                guard let user = Auth.auth().currentUser else {
                    completion(URLError(.badURL))
                    return
                }

                user.delete { error in
                    completion(error)
                }
            }
    
    func fetchUser() async{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try?  snapshot.data(as: User.self)
    }
    
    func generateGreeting(for name: String) -> String {
            let hour = Calendar.current.component(.hour, from: Date())
            
            var greetingText = ""
            
            switch hour {
            case 0..<12:
                greetingText = "Good Morning"
            case 12..<17:
                greetingText = "Good Afternoon"
            default:
                greetingText = "Good Evening"
            }
            
            return "\(greetingText), \(name)"
        }

}
    
