//
//  ContentView.swift
//  Scrumdinger
//
//  Created by seif elshahet on 01/12/2023.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    var body: some View {
        ZStack {
                   RoundedRectangle(cornerRadius: 16.0)
                       .fill(scrum.theme.mainColor)
                   VStack {
                       
                       MeetingHeaderView(secondElaped: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                       
                       MeetingTimerView(speakers: scrumTimer.speakers, theme: scrum.theme, isRecording: isRecording)
                       
                       MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
                      
                   }
               }
               .padding()
               .foregroundColor(scrum.theme.accentColor)
               .onAppear {
                   startScrum()
               }
               .onDisappear {
                   endScrum()
               }
               .navigationBarTitleDisplayMode(.inline)
           }
    
    private func endScrum() {
        scrumTimer.stopScrum()
        speechRecognizer.stopTranscribing()
        isRecording = false
        let newHistory = History(attendees: scrum.attendees, transcript: speechRecognizer.transcript)
        scrum.history.insert(newHistory, at: 0)
    }
    
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        scrumTimer.startScrum()
    }
        
    }


#Preview {
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}