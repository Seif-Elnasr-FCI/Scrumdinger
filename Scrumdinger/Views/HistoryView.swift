//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by seif elshahet on 10/12/2023.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                
                Text("Attendees")
                    .font(.headline)
                
                Text(history.attendeeString)
                
                if let transcript = history.transcript {
                    Text("Trancript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

var history: History {
        History(attendees: [
            DailyScrum.Attendee(name: "Jon"),
            DailyScrum.Attendee(name: "Darla"),
            DailyScrum.Attendee(name: "Luis")
        ],
                transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI...")
    }

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
}

#Preview {
    HistoryView(history: history)
}
