//
//  TabView.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 4/29/24.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNameSpace
    let tabBarItems: [(image: String, title: String)] = [
    ("house", "Home"),
    ("graduationcap", "Grades"),
    ("chart.bar", "GPA"),
    ("person", "Profile")
    ]
    var body: some View {
        ZStack(){
            Capsule()
                .frame(height: 80)
                .foregroundColor(Color(.secondarySystemBackground))
                .shadow(radius: 2)
            
            HStack{
                ForEach(0..<4){ index in
                    Button{tabSelection = index + 1 } label: {
                        VStack(spacing: 8){
                            Spacer()
                            
                            Image(systemName: tabBarItems[index].image)
                            
                            Text(tabBarItems[index].title)
                                .font(.caption)
                            
                            if index + 1 == tabSelection{
                                Capsule()
                                    .frame(height: 8)
                                    .foregroundColor(Color(red: 1, green: 0.149, blue: 0))
                                    .matchedGeometryEffect(id: "SelectedTab", in: animationNameSpace)
                                    .offset(y: 3)
                            } else {
                                Capsule()
                                    .frame(height: 8)
                                    .foregroundColor(.clear)
                                    .offset(y: 3)
                            }
                        }
                        .foregroundColor(index + 1 == tabSelection ? Color(red: 1, green: 0.149, blue: 0) : .gray)
                        .fontWeight(.semibold)
                    }
                }
            }
            .frame(height: 80)
            .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

#Preview {
    CustomTabView(tabSelection: .constant(1))
        .previewLayout(.sizeThatFits)
        .padding(.vertical)
}
