//
//  HomeView.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 4/29/24.
//

import SwiftUI

struct HomeView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        let selectedClassManager = SelectedClassManager()
        let classCountManager = ClassCountManager(selectedClassCount: 1)
        let levelManager = LevelManager(selectedLevel: "Select")
        
        return TabView(selection: $tabSelection) {
            Starter()
                .tag(1)
            
            GradeView()
                .tag(2)
                .environmentObject(selectedClassManager)
                .environmentObject(classCountManager)
                .environmentObject(levelManager)
            
            GpaView()
                .tag(3)
            
            ProfileView()
                .tag(4)
        }
        .overlay(alignment: .bottom) {
            CustomTabView(tabSelection: $tabSelection)
        }
    }
}

#Preview {
    HomeView()
}


