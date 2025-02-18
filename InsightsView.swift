import SwiftUI
import SwiftData
import Charts

struct InsightsView: View {
    @Query(sort: \DayEntry.date, order: .forward) private var moodEntries: [DayEntry]
    @Query(sort: \MeditationSession.date, order: .forward) private var meditationSessions: [MeditationSession]

    @State private var selectedTimeframe: Timeframe = .weekly

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ChartCardView(title: "Mood Trend") {
                        moodTrendChart
                    }
                    
                    ChartCardView(title: "Mood Distribution") {
                        moodDistributionChart
                    }

                    ChartCardView(title: "Meditation Sessions") {
                        timeframePicker
                        meditationChart
                    }
                }
                .padding()
                .navigationTitle("Insights")
            }
        }
    }

    private var moodTrendChart: some View {
        Chart(moodEntries) { entry in
            LineMark(
                x: .value("Date", entry.date),
                y: .value("Mood", moodValue(for: entry.moodRating))
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(Color.purple)
        }
        .frame(height: 200)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
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
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }

    private var timeframePicker: some View {
        Picker("Timeframe", selection: $selectedTimeframe) {
            Text("Weekly").tag(Timeframe.weekly)
            Text("Monthly").tag(Timeframe.monthly)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }

    private var meditationChart: some View {
        let filteredSessions = meditationSessions.filter { session in
            let calendar = Calendar.current
            let now = Date()

            switch selectedTimeframe {
            case .weekly:
                return calendar.isDate(session.date, equalTo: now, toGranularity: .weekOfYear)
            case .monthly:
                return calendar.isDate(session.date, equalTo: now, toGranularity: .month)
            }
        }

        return Chart(filteredSessions) { session in
            BarMark(
                x: .value("Date", session.date, unit: .day),
                y: .value("Minutes", session.duration)
            )
            .foregroundStyle(Color.blue)
        }
        .frame(height: 200)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }

    private func moodValue(for mood: MoodRating) -> Int {
        switch mood {
        case .happy: return 3
        case .neutral: return 2
        case .sad: return 1
        case .stressed: return 4
        case .relaxed: return 5
        }
    }

    enum Timeframe {
        case weekly
        case monthly
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
                .foregroundColor(.primary)
            
            content
                .padding()
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
