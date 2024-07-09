//
//  CategoryNameView.swift
//  ArgyleSuccess
//
//  Created by David Aiyeyemi on 5/28/24.
//

import SwiftUI

struct CategoryNameView: View {
    @Binding var selectedLevel: String
    let classNumber: Int
    @State private var categories: [String] = ["Category 1", "Category 2", "Category 3"]
    
    var body: some View {
        VStack {
            Text("Categories for Class \(classNumber)")
                .font(.largeTitle)
                .padding()
            
            List(categories, id: \.self) { category in
                NavigationLink(destination: ClassDetailSubview(selectedSubject: .constant(category), selectedLevel: $selectedLevel, categories: .constant([Category]()), classNumber: classNumber)) {
                    Text(category)
                }
            }
            
            Spacer()
        }
        .navigationBarTitle("Category Names", displayMode: .inline)
    }
}

struct CategoryNameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryNameView(selectedLevel: .constant("Freshman"), classNumber: 1)
        }
    }
}

