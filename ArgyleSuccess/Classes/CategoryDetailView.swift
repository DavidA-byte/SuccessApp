//
//  CategoryDetailView.swift
//  ArgyleSuccess
//
//  Created by David Aiyeyemi on 5/16/24.
//

import SwiftUI

struct CategoryDetailView: View {
    var category: Category

    var body: some View {
        VStack {
            Text("Category Details")
                .font(.largeTitle)
            Text("Category Name: \(category.name)")
            Text("Weight: \(category.weight)")
            // Add more detailed views as needed
        }
        .padding()
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(category: Category(name: "Test Category", weight: 50.0, grades: [85.0, 90.0, 95.0]))
    }
}
