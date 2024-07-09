//
//  Event.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 5/1/24.
//

import SwiftUI
import EventKit

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let location: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
            
            Text("Date: \(date)")
                .font(.caption)
            
            Text("Location: \(location)")
                .font(.caption)
        }
        
    }
}

#Preview {
    Event(title: "Sample Event", date: "May 1, 2024", location: "Sample Location") as! any View
}
