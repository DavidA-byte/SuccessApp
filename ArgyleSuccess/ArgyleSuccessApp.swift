//
//  ArgyleSuccessApp.swift
//  ArgyleSuccess
//
//  Created by David Aiyeyemi on 5/2/24.
//

import SwiftUI
import Firebase

@main
struct ArgyleSuccessApp: App {
        @StateObject var viewModel = AuthViewModel()
        
        init(){
            FirebaseApp.configure()
        }
        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(viewModel)
            }
        }
    }
