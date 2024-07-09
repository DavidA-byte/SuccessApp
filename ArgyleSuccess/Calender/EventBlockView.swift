//
//  EventBlockView.swift
//  GPA_Calculator
//
//  Created by David Aiyeyemi on 5/1/24.
//


import SwiftUI

struct EventBlockView: View {
    let eventBlock: EventBlock

    var body: some View {
        VStack(alignment: .leading) {
                       Text(eventBlock.title)
                           .font(.headline)
                           .padding(.bottom, 10)
                       
                       ForEach(eventBlock.events) { event in
                           EventCardView(event: event)
                               .frame(maxWidth: .infinity) // Stretch to fill the width
                       }
                   }
                   .padding()
                   .background(Color.white)
                   .cornerRadius(10)
                   .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        
               }
           }

struct EventBlockView_Previews: PreviewProvider {
    static var previews: some View {
        let eventBlock = EventBlock(title: "Hi 1", events: [
            Event(title: "Event 1", date: "May 1, 2024", location: "Location 1"),
            Event(title: "Event 2", date: "May 1, 2024", location: "Location 2")
        ])
        
        return EventBlockView(eventBlock: eventBlock)
    }
}
