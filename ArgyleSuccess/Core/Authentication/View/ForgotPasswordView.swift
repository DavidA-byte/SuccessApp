import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email = ""
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    @State private var error: Error?
    @State private var errorString: String = ""
    
    var body: some View {
        VStack {
            // Image
            Image("argyleeagles-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 175, height: 140)
                .padding(.vertical, 32)
            
            // Description
            Text("Enter your email address to reset your password.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 8)
            
            // Email Input Field
            InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                .padding(.horizontal)
                .padding(.top, 12)
            
            // Forgot Password Button
            Button(action: {
                AuthViewModel.resetPassword(email: email) { resetResult in
                    switch resetResult {
                    case .failure(let error):
                        self.error = error
                        self.errorString = error.localizedDescription
                    case .success:
                        self.error = nil
                        self.errorString = ""
                    }
                    self.showAlert = true
                }
            }) {
                HStack {
                    Text("RESET")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                
            }
            .background(Color(Color(red: 1, green: 0.149, blue: 0))
                .fontWeight(.semibold))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 24)
            
            
            Spacer()
            
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Password Reset"),
                message: Text(self.errorString.isEmpty ? "Success. Reset sent successfully. Check your email" : self.errorString),
                dismissButton: .default(Text("OK")) {
                    self.dismiss()
                }
            )
        }
        .onAppear {
            self.errorString = ""
        }
        Text("NOTE: Make Sure Your Email Already Has An Account!")
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding(.top, 8)
        
        Spacer()
        
        NavigationLink{
            LoginView()
                .navigationBarBackButtonHidden(true)
        } label: {
            HStack(spacing: 3){
                Text("Already Have An Account?")
                Text("Log In")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            .font(.system(size: 14))
            .foregroundColor(Color(red: 1, green: 0.149, blue: 0))
            .fontWeight(.semibold)
        }
    }
    
}

extension  ForgotPasswordView: AuthenticationFormProtocal{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
