//
//  Starter.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 5/1/24.
//

import SwiftUI

struct Starter: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showEvents = false // Track whether to show events
    
    let events: [Event] = [
        Event(title: "Shoot for the Stars", date: "May 3, 2024", location: "Argyle High School"),
        Event(title: "Election Day\nShoot for the Stars\nAHS Band Banquet", date: "May 4 2024", location: "Argyle High School"),
        Event(title: "AP Testing", date: "May 6, 2024", location: "Argyle High School"),
        Event(title: "AP Testing", date: "May 7, 2024", location: "Argyle High School"),
        Event(title: "AP Testing", date: "May 8, 2024", location: "Argyle High School")
//        Event(title: "Event 2", date: "May 2, 2024", location: "Location 2"),
//        Event(title: "Event 2", date: "May 2, 2024", location: "Location 2")
        ]
        
        
        
// Initially empty
    
    var body: some View {
        VStack {
            if let user = viewModel.currentUser {
                Text(viewModel.generateGreeting(for: user.fullname))
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
            }
            
            
            
            if events.isEmpty && !showEvents { // Show only if events are empty and showEvents is false
                Text("No upcoming events")
                    .font(.headline)
                    .padding()
                    .onAppear {
                        // Simulate a delay before showing events (remove in production)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showEvents = true
                        }
                    }
            } else if !events.isEmpty || showEvents { // Show if events are not empty or showEvents is true
                ScrollView {
                    Text("Upcoming events")
                        .font(.headline)
                        .padding()
                    
                    LazyVStack {
                            ForEach(events) { event in
                                EventCardView(event: event)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                }
            }
        }

#Preview {
    Starter()
        .environmentObject(AuthViewModel()) // Add a dummy view model for preview
}
