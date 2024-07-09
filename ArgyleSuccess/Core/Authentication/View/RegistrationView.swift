//
//  RegistrationView.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 4/26/24.
//

import SwiftUI
//Add error that email is already in use
struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var cconfirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack{
            Image("argyleeagles-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 175, height: 140)
                .padding(.vertical, 15)
            
            VStack(spacing: 24){
                    InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    InputView(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal)
                        .padding(.top, 12)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter Your Password", isSecureField: true)
                        .textContentType(nil)
                        .padding(.horizontal)
                        .padding(.top, 12)
                    
                
                
                ZStack(alignment: .trailing){
                    InputView(text: $cconfirmPassword, title: "Confirm Password", placeholder: "Confirm Your Password", isSecureField: true)
                    
                    
                    if !password.isEmpty && !cconfirmPassword.isEmpty{
                        if password == cconfirmPassword{
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else{
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button{
                    Task{
                        try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                    }
                } label: {
                    HStack{
                        Text("SIGN UP")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    
                }
                .background(Color(red: 1, green: 0.149, blue: 0))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top,24)
                
                Spacer()
                
                Button{
                    dismiss()
                } label: {
                    HStack(spacing: 3){
                        Text("Already have an account?")
                        Text("Sign In")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 1, green: 0.149, blue: 0))
                }
            }
        }
    }
}

extension  RegistrationView: AuthenticationFormProtocal{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        
        && cconfirmPassword == password
        && !fullname.isEmpty
    }
}
    #Preview {
        RegistrationView()
    }

