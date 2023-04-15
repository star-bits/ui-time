//
//  ui_timeApp.swift
//  ui-time
//
//  Created by star-bits on 2023-04-15.
//

import SwiftUI

@main
struct ui_timeApp: App {
    @State var currentTime: String = "15:00"
    @State private var remainingTime: TimeInterval = 15 * 60
    @State private var timer: Timer? = nil

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
                currentTime = formatTime(remainingTime)
            } else {
                timer?.invalidate()
            }
        }
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func resetTimer() {
        remainingTime = 15 * 60
        currentTime = formatTime(remainingTime)
        startTimer()
    }

    var body: some Scene {
//        MenuBarExtra(currentTime, systemImage: "star") {
//        MenuBarExtra("star") {
        MenuBarExtra(formatTime(remainingTime)) {
            Button("Another!") {
                resetTimer()
            }
//            .keyboardShortcut("1")

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        }
    }
}
