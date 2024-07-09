//
//  ProfileView.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 4/26/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    var body: some View {
        if let user = viewModel.currentUser{
            List{
                Section{
                    HStack{
                        Text(user.initals)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                        
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        VStack (alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text((user.email))
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                        }
                    }
                }
                Section ("General"){
                    HStack{
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Section ("Account"){
                    Button{
                        viewModel.signOut()
                    } label:{
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color.red)
                    }
                    
                    Button(role: .destructive) {
                        viewModel.deleteAccount { error in
                            if let error = error {
                                let deleteError = error as NSError
                                alertTitle = "Error"
                                alertMessage = "Error deleting account: \(deleteError.localizedDescription)"
                            } else {
                                alertTitle = "Success"
                                alertMessage = "Account deleted successfully. Please sign out."
                            }
                            showAlert = true
                        }
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: Color.red)
                        
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(alertTitle),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK")) {
                                // Perform sign out logic here
                            }
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}

