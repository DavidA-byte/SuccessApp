//
//  CalenderView.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 5/1/24.
//

import SwiftUI

struct CalenderView: View {
    let id: UUID
        let title: String
        let events: [Event]

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy" // Customize the date format as per your requirements
            return formatter
        }()

        init(id: UUID, title: String, events: [Event]) {
            self.id = id
            self.title = title
            self.events = events
        }

        var body: some View {
            VStack {
                Text("Upcoming Events")
                    .font(.title)
                    .padding(.bottom, 10)

                if events.isEmpty {
                    Text("No upcoming events")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(spacing: 20) {
                            ForEach(events) { event in
                                EventBlockView(eventBlock: EventBlock(title: event.title, events: [event]))
                                
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                }
            }
        }
    }
#Preview {
    let sampleEvents = [
           Event(title: "Event 1", date: "May 1, 2024", location: "Location 1"),
           Event(title: "Event 2", date: "May 2, 2024", location: "Location 2")
       ]
        return CalenderView(id: UUID(), title: "Sample Title", events: sampleEvents)
    }
