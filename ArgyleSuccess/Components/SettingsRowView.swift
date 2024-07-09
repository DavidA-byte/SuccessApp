//
//  SettingsRowView.swift
//  ArgyleSuccess
//
//  Created by David Aiyeyemi on 5/2/24.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                .preferredColorScheme(.light)
            
            SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}

