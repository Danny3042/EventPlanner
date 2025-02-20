import Foundation
import SwiftUI

struct MoodEntryCard: View {
    var entry: DayEntry

    var body: some View {
        VStack {
            Text("Mood for \(formattedDate(entry.date))")
                .font(.headline)
            Text(moodEmoji(for: entry.moodRating))
                .font(.largeTitle)
            // Additional mood details can be added here
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }

    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }

    private func moodEmoji(for mood: MoodRating) -> String {
        switch mood {
        case .happy: return "😄"
        case .neutral: return "😐"
        case .sad : return "😔"
        case .stressed: return "😫"
        case .relaxed: return "😌"
        }
    }
}
