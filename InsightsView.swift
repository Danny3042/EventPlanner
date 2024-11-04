import SwiftUI
import SwiftData
import Charts

struct InsightsView: View {
    @Query(sort: \DayEntry.date, order: .forward) private var moodEntries: [DayEntry] // Fetch all entries

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ChartCardView(title: "Mood Trend") {
                    moodTrendChart
                }
                
                ChartCardView(title: "Mood Distribution") {
                    moodDistributionChart
                }
            }
            .padding()
            .navigationTitle("Insights")
        }
    }

    private var moodTrendChart: some View {
        Chart(moodEntries) { entry in
            LineMark(
                x: .value("Date", entry.date),
                y: .value("Mood", moodValue(for: entry.moodRating))
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(.purple)
        }
        .frame(height: 200)
    }
    
    private var moodDistributionChart: some View {
        Chart {
            ForEach(MoodRating.allCases, id: \.self) { mood in
                BarMark(
                    x: .value("Mood", mood.description),
                    y: .value("Count", moodEntries.filter { $0.moodRating == mood }.count)
                )
                .foregroundStyle(by: .value("Mood", mood.description))
            }
        }
        .frame(height: 200)
    }

    private func moodValue(for mood: MoodRating) -> Int {
        switch mood {
        case .happy: return 3
        case .neutral: return 2
        case .sad: return 1
        }
    }
}

struct ChartCardView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.leading)
                .padding(.top, 10)
            
            content
                .padding()
        }
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)))
        .shadow(radius: 5)
    }
}

