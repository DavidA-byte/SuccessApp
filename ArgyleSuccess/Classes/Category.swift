//
//  Category.swift
//  ArgyleSuccess
//
//  Created by David Aiyeyemi on 5/3/24.
//

import Foundation

struct Category: Identifiable, Codable {
    let id: UUID
    var name: String
    var weight: Double
    var grades: [Double]

    init(id: UUID = UUID(), name: String, weight: Double, grades: [Double]) {
        self.id = id
        self.name = name
        self.weight = weight
        self.grades = grades
    }
}

struct ClassDetail: Identifiable {
    var id = UUID()
    var name: String
    var categories: [Category]
}


struct GradeLevel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var grade: Double  // Represents the overall grade for this grade level

    init(name: String, grade: Double) {
        self.name = name
        self.grade = grade
    }
}
