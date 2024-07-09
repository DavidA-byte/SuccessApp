//
//  SelectedClassManager.swift
//  ArgyleSuccess
//
//  Created by David Aiyeyemi on 5/28/24.
//

import SwiftUI

class SelectedClassManager: ObservableObject {
    @Published var selectedClass: String = "Select"
    let graduatingClasses = ["Select","2024", "2025", "2026", "2027","2028"]
}
