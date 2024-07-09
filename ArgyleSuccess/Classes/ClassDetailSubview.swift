import SwiftUI

extension NumberFormatter {
    static let decimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}


struct ClassDetailSubview: View {
    @Binding var selectedSubject: String
    @Binding var selectedLevel: String
    @Binding var categories: [Category]
    let classNumber: Int
    
    private var selectedSubjectKey: String {
        "SelectedSubject\(classNumber)"
    }
    
    private var selectedLevelKey: String {
        "SelectedLevel\(classNumber)"
    }
    
    private var categoriesKey: String {
        "Categories\(classNumber)"
    }
    
    private var isUILSelected: Bool {
        selectedSubject == "UIL"
    }
    
    private var navigationTitle: String {
        isUILSelected ? "UIL" : "\(selectedLevel) - \(selectedSubject)"
    }
    
    private var shouldDisplayAddCategoryButton: Bool {
        selectedLevel != "Select" && selectedSubject != "Select"
    }
    
    private var isCategoryCompleted: Bool {
        let allCategoriesFilled = categories.allSatisfy { !$0.name.isEmpty && $0.weight != 0.0 }
        if !allCategoriesFilled {
            return false
        }
        
        let totalWeight = categories.reduce(0) { $0 + $1.weight }
        let epsilon: Double = 0.001
        let isWeightCorrect = abs(totalWeight - 100.0) < epsilon
        return isWeightCorrect
    }
    
    private var totalGrade: Double {
        guard isCategoryCompleted else {
            return 0.0
        }
        
        return categories.reduce(0.0) { result, category in
            let categoryAverage = category.grades.reduce(0.0, +) / Double(category.grades.count)
            return result + (categoryAverage * category.weight / 100)
        }
    }
    
    private var adjustedGrade: Double {
        var grade = totalGrade
        let currentYear = Calendar.current.component(.year, from: Date())
        switch selectedLevel {
        case "AP":
            grade += currentYear <= 2025 ? 10 : 10
        case "Honors":
            grade += 7
        case "Dual Credit":
            grade += currentYear <= 2025 ? 10 : 7
        case "UIL":
            grade += 7
        default:
            break
        }
        return grade
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Picker(selection: $selectedLevel, label: Text("Level")) {
                        ForEach(courseLevels, id: \.self) { level in
                            Text(level)
                                .tag(level)
                                .foregroundColor(.red)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    
                    Picker(selection: $selectedSubject, label: Text("Subject")) {
                        ForEach(subjects, id: \.self) { subject in
                            Text(subject)
                                .tag(subject)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                }
                
                if selectedLevel == "Select" || selectedSubject == "Select" {
                    Text("Please select a level and subject")
                        .font(.largeTitle)
                        .padding()
                } else {
                    if isCategoryCompleted {
                        VStack {
                            WeightedGradeView(adjustedGrade: adjustedGrade)
                            UnweightedGradeView(totalGrade: totalGrade)
                        }
                    }
                    
                    ForEach($categories) { $category in
                        VStack {
                            CategoryView(category: $category, isCompleted: isCategoryCompleted)
                            Button(action: {
                                if let index = categories.firstIndex(where: { $0.id == category.id }) {
                                    categories.remove(at: index)
                                    saveCategories()
                                }
                            }) {
                                Text("Delete Category")
                                    .foregroundColor(.red)
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    
                    if shouldDisplayAddCategoryButton {
                        Button(action: {
                            categories.append(Category(name: "", weight: 0.0, grades: []))
                            saveCategories()
                        }) {
                            Text("Add Category")
                        }
                        .padding(.bottom, 20)
                    }
                }
                
                Spacer()
            }
            .onAppear {
                if let savedSubject = UserDefaults.standard.string(forKey: selectedSubjectKey) {
                    selectedSubject = savedSubject
                }
                
                if let savedLevel = UserDefaults.standard.string(forKey: selectedLevelKey) {
                    selectedLevel = savedLevel
                }
                
                if let savedCategoriesData = UserDefaults.standard.data(forKey: categoriesKey),
                   let savedCategories = try? JSONDecoder().decode([Category].self, from: savedCategoriesData) {
                    categories = savedCategories
                }
            }
            .onDisappear {
                UserDefaults.standard.set(selectedSubject, forKey: selectedSubjectKey)
                UserDefaults.standard.set(selectedLevel, forKey: selectedLevelKey)
                saveCategories()
            }
            .navigationTitle(navigationTitle)
        }
    }
    
    private func saveCategories() {
        if let encodedCategories = try? JSONEncoder().encode(categories) {
            UserDefaults.standard.set(encodedCategories, forKey: categoriesKey)
        }
    }
}

struct UnweightedGradeView: View {
    var totalGrade: Double
    
    var body: some View {
        Text("Unweighted Grade: \(totalGrade, specifier: "%.2f")%")
            .font(.headline)
            .foregroundColor(.red)
            .fontWeight(.bold)
            .padding()
    }
}


struct WeightedGradeView: View {
    var adjustedGrade: Double
    
    var body: some View {
        Text("Weighted Grade: \(adjustedGrade, specifier: "%.2f")%")
            .font(.headline)
            .foregroundColor(.red)
            .fontWeight(.bold)
            .padding()
    }
}


struct CategoryView: View {
    @Binding var category: Category
    var isCompleted: Bool
    
    var body: some View {
        VStack {
            TextField("Category Name", text: $category.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            HStack {
                Text("Weight:")
                Spacer()
                HStack {
                    TextField("Weight", value: $category.weight, formatter: NumberFormatter.decimal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80)
                        .multilineTextAlignment(.trailing)
                    Text("%")
                }
            }
            .padding(.horizontal)
            
            ForEach($category.grades.indices, id: \.self) { index in
                HStack {
                    Text("Grade \(index + 1):")
                    Spacer()
                    HStack {
                        TextField("Grade", value: $category.grades[index], formatter: NumberFormatter.decimal)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 80)
                            .multilineTextAlignment(.trailing)
                        Text("%")
                    }
                    Button(action: {
                        category.grades.remove(at: index)
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)
            }
            
            Button(action: {
                category.grades.append(0.0)
            }) {
                Text("Add Grade")
            }
            .padding(.bottom, 10)
            .foregroundColor(.red)
            .fontWeight(.bold)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(isCompleted ? Color.red : Color.gray, lineWidth: 1))
        .padding(.vertical, 5)
    }
}

// Sample data
let courseLevels = ["Select", "Honors", "AP", "Dual Credit", "On-Level"]
let subjects = ["Select", "Math", "Science", "English", "History", "UIL"]

// Preview
struct ClassDetailSubview_Previews: PreviewProvider {
    @State static var selectedSubject = "Math"
    @State static var selectedLevel = "AP"
    @State static var categories = [Category(name: "Homework", weight: 40.0, grades: [95.0, 88.0]),
                                    Category(name: "Exams", weight: 60.0, grades: [92.0])]
    
    static var previews: some View {
        NavigationView {
            ClassDetailSubview(selectedSubject: $selectedSubject, selectedLevel: $selectedLevel, categories: $categories, classNumber: 1)
        }
    }
}
