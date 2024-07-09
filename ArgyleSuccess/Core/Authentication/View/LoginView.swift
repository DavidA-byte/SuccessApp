//
//  LoginView.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 4/26/24.
//


import SwiftUI

struct LoginView: View {
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            VStack{
                //image
                Image("argyleeagles-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 175, height: 140)
                    .padding(.vertical, 15)
                
                //form fields
                VStack(spacing: 24){
                    InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter Your Password", isSecureField: true)
                }
                
                
                
                //Forgot Password
                .padding(10)
                NavigationLink{
                    ForgotPasswordView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3){
                        Spacer()
                            .frame(width: 250)
                        Text("Forgot Password?")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 1, green: 0.149, blue: 0))
                    .fontWeight(.semibold)
                }
                
                //sign up button
                Button {
                    Task {
                        do {
                            try await viewModel.signIn(withEmail: email, password: password)
                           
                        } catch {
                            showAlert = true
                            alertTitle = "Error"
                            alertMessage = "Invalid username or password."
                        }
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
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
                .padding(.top, 24)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                Spacer()
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3){
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 1, green: 0.149, blue: 0))
                    .fontWeight(.semibold)
                }
                
            }
        }
    }
}
extension  LoginView: AuthenticationFormProtocal{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}
    
    #Preview {
        LoginView()
    }

