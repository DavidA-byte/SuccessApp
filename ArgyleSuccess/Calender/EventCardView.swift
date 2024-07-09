import SwiftUI

struct EventCardView: View {
    let event: Event

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.subheadline)
                .padding(.bottom, 2)

            Text(event.date)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 4)

            Text(event.location)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(16) // Increase padding around the VStack
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .frame(maxWidth: .infinity)
    }
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        let event = Event(title: "Sample Event", date: "Sample Date", location: "Sample Location")
        return EventCardView(event: event)
    }
}
