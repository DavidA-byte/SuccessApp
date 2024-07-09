////
////  ClassDetailView.swift
////  ArgyleSuccess
////
////  Created by David Aiyeyemi on 5/3/24.
////
//
//import SwiftUI
//
//struct ClassListDetailView: View {
//    let classes: [String]
//    @State private var selectedClass: String?
//    @State private var selectedGrade: String?
//
//    var body: some View {
//        VStack {
//            ForEach(classes, id: \.self) { className in
//                VStack {
//                    NavigationLink(
//                        destination: GradeView(),
//                        isActive: Binding(
//                            get: {
//                                selectedClass == className
//                            },
//                            set: { isActive in
//                                if isActive {
//                                    selectedClass = className
//                                } else {
//                                    selectedClass = nil
//                                }
//                            }
//                        )
//                    ) {
//                        Text(className)
//                            .font(.title)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//
//                    if selectedClass == className {
//                        Picker("Select Grade", selection: $selectedGrade) {
//                            ForEach(getGrades(), id: \.self) { grade in
//                                Text(grade).tag(grade)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .padding()
//                    }
//                }
//            }
//        }
//        .navigationTitle("Classes")
//    }
//    
//    // Function to get the available grades
//    func getGrades() -> [String] {
//        // Replace this with your logic to fetch the available grades
//        return ["A", "B", "C", "D", "F"]
//    }
//}
//
//struct ClassListDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClassListDetailView(classes: ["Math", "Science", "History"])
//    }
//}
