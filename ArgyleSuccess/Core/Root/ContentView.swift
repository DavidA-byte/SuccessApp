//
//  ContentView.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 4/26/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group{
            if viewModel.userSession != nil{
               HomeView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
