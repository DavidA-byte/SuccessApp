//
//  EventBlock.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 5/1/24.
//

import SwiftUI
import EventKit

struct EventBlock: View {
    let title: String
        let events: [Event]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 10)
            
            ForEach(events) { event in
                Text(event.title)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    EventBlock(title: "Sample Block", events: [
        Event(title: "Event 1", date: "May 1, 2024", location: "Location 1"),
        Event(title: "Event 2", date: "May 2, 2024", location: "Location 2")
    ])
}
