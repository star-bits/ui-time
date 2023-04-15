# ui-time: 15 minutes of uninterrupted time

![demo](https://user-images.githubusercontent.com/93939472/232224559-2a08e4d1-f89b-4e85-8f69-f7f54eb3a0d6.gif)

[ui-time.app.zip](https://github.com/star-bits/ui-time/files/11239541/ui-time.app.zip)

- This SwiftUI application displays a 15-minute countdown timer in the macOS menu bar.
- The user can reset the timer to 15 minutes by clicking "Another round of uninterrupted time!" or quit the app using the "Quit" button.

## `./ui-time/ui_timeApp.swift`
```swift
import SwiftUI

// TimerViewModel is an ObservableObject that handles the timer logic and updates the current time displayed in the menu bar.
class TimerViewModel: ObservableObject {
    // currentTime is a published variable that stores the current time as a string, initially set to "15:00".
    @Published var currentTime: String = "15:00"
    // remainingTime is a private variable that stores the remaining time in seconds.
    private var remainingTime: TimeInterval = 15 * 60
    // timer is a private optional Timer variable that will be used to schedule and manage the timer.
    private var timer: Timer? = nil

    // The init method starts the timer when TimerViewModel is initialized.
    init() {
        startTimer()
    }

    // The startTimer method invalidates any existing timer, creates a new timer, and schedules it to update the remainingTime.
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                self.currentTime = self.formatTime(self.remainingTime)
            } else {
                self.timer?.invalidate()
            }
        }
    }

    // The formatTime method formats the given time interval into a string in the "mm:ss" format.
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // The resetTimer method resets the remainingTime to 15 minutes and 1 second and starts the timer.
    func resetTimer() {
        remainingTime = 15 * 60 + 1
        startTimer()
    }
}

// The main App struct creates a timerViewModel and displays the timer in the menu bar with action buttons.
@main
struct ui_timeApp: App {
    // timerViewModel is a StateObject that will manage the timer logic and display the current time.
    @StateObject private var timerViewModel = TimerViewModel()

    // body defines the app scene that includes a menu bar with the current time, a reset button, and a quit button.
    var body: some Scene {
        MenuBarExtra(timerViewModel.currentTime) {
            // Reset button with a keyboard shortcut "r" to reset the timer.
            Button("Another round of uninterrupted time!") {
                timerViewModel.resetTimer()
            }
            .keyboardShortcut("r")

            // Divider to separate the reset button from the quit button.
            Divider()

            // Quit button with a keyboard shortcut "q" to quit the app.
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        }
    }
}
```

## On the next version:
- [ ] Align the timer text `mm:ss` using the separator `:`
- [ ] Sync the timer to the system time.
- [ ] Make an app icon.
