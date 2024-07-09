//
//  GradeView.swift
//  ArgyleSuccess
//
//  Created by David Aiyeyemi on 5/2/24.
//


import SwiftUI

class ClassCountManager: ObservableObject {
    @Published var selectedClassCount: Int

    init(selectedClassCount: Int) {
        self.selectedClassCount = selectedClassCount
    }
}

class LevelManager: ObservableObject {
    @Published var selectedLevel: String

    init(selectedLevel: String) {
        self.selectedLevel = selectedLevel
    }
}

struct GradeView: View {
    @EnvironmentObject var selectedClassManager: SelectedClassManager
    @EnvironmentObject var classCountManager: ClassCountManager
    @EnvironmentObject var levelManager: LevelManager

    @State private var selectedOption: String = UserDefaults.standard.string(forKey: "SelectedOption") ?? ""
    let options = ["Option 1", "Option 2", "Option 3"]
    let gradeOptions = ["Select", "Freshman", "Sophomore", "Junior", "Senior"]
    let classCountOptions = [1, 2, 3, 4, 5, 6, 7, 8]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Setup Your Academic Details")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()

                    HStack(spacing: 20) {
                        Text("Graduating Class")
                            .font(.headline)
                        Picker("Select Graduating Class", selection: $selectedClassManager.selectedClass) {
                            ForEach(selectedClassManager.graduatingClasses, id: \.self) { graduatingClass in
                                Text(graduatingClass)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                    }
                    .padding(.horizontal)

                    HStack(spacing: 20) {
                        Text("Grade Level")
                            .font(.headline)
                        Picker("Select Grade Level", selection: $levelManager.selectedLevel) {
                            ForEach(gradeOptions, id: \.self) { option in
                                Text(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                    }
                    .padding(.horizontal)

                    HStack(spacing: 20) {
                        Text("Number of Classes")
                            .font(.headline)
                        Picker("Select Number of Classes", selection: $classCountManager.selectedClassCount) {
                            ForEach(classCountOptions, id: \.self) { count in
                                Text("\(count)")
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: QuartersSemestersView()) {
                        Text("Proceed")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            .background(Color(red: 1, green: 0.149, blue: 0))
                            .cornerRadius(10)
                            .opacity((levelManager.selectedLevel != "Select" && selectedClassManager.selectedClass != "Select") ? 1.0 : 0.5)
                    }
                    .disabled(levelManager.selectedLevel == "Select" || selectedClassManager.selectedClass == "Select")
                    
                    Spacer()
                }
                .padding(.vertical)
                .navigationBarTitle("Grades")
            }
        }
    }
}


struct QuartersSemestersView: View {
    @EnvironmentObject var selectedClassManager: SelectedClassManager
    @EnvironmentObject var classCountManager: ClassCountManager
    @EnvironmentObject var levelManager: LevelManager
    
    var categoryNames: [String] {
        ["Quarter 1", "Quarter 2", "Semester 1 Exam", "Semester 1", "Quarter 3", "Quarter 4", "Semester 2 Exam", "Semester 2"]
            .map { "\($0) - \(selectedClassManager.selectedClass)" }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(categoryNames, id: \.self) { categoryName in
                    NavigationLink(destination: ClassesView(categoryName: categoryName, classCount: $classCountManager.selectedClassCount, selectedLevel: $levelManager.selectedLevel, selectedClass: $selectedClassManager.selectedClass)) {
                        Text(categoryName)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Classes")
        }
    }
}

struct ClassesView: View {
    let categoryName: String
    @Binding var classCount: Int
    @Binding var selectedLevel: String
    @Binding var selectedClass: String

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(1...classCount, id: \.self) { classIndex in
                    NavigationLink(destination: ClassDetailSubviewWrapper(classIndex: classIndex, selectedLevel: $selectedLevel, selectedClass: $selectedClass)) {
                        Text("Class \(classIndex)")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            .background(Color(red: 1, green: 0.149, blue: 0))
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer()
            }
            .padding()
            .navigationTitle(categoryName)
        }
    }
}

struct ClassDetailSubviewWrapper: View {
    let classIndex: Int
    @Binding var selectedLevel: String
    @Binding var selectedClass: String

    @State private var selectedSubject: String = "Select"
    @State private var categories: [Category] = [Category(name: "", weight: 0.0, grades: [])]

    var body: some View {
        ClassDetailSubview(
            selectedSubject: $selectedSubject,
            selectedLevel: $selectedLevel,
            categories: $categories,
            classNumber: classIndex
        )
        .navigationTitle("Class \(classIndex)")
    }
}

struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        GradeView()
    }
}




//FUTURE - UPDATEz
//                    if selectedClass != "" {
//                        NavigationLink(destination: ClassDetailView(className: selectedClass)) {
//                            Text("Go to \(selectedClass) class detail")
//                        }
//                    }
