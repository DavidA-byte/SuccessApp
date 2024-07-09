//
//  InputView.swift
//  ArgyleSuccess
//
//  Created by David Aiyeyemi on 5/2/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .font(.system(size:14))
                    .autocapitalization(.none)

            } else{
                TextField(placeholder, text: $text)
                    .font(.system(size:14))
                    .autocapitalization(.none)

            }
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}
