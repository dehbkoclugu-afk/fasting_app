import WidgetKit
import SwiftUI

struct FastingEntry: TimelineEntry {
    let date: Date
    let isFasting: Bool
    let planName: String
    let remainingTime: String
    let progress: Double
    let phaseName: String
}

struct FastingWidgetProvider: TimelineProvider {
    let appGroupId = "group.com.dehbkoclugu.fasttrack"

    func placeholder(in context: Context) -> FastingEntry {
        FastingEntry(
            date: Date(),
            isFasting: true,
            planName: "16:8",
            remainingTime: "08:30:00",
            progress: 0.47,
            phaseName: "Fat Burning"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (FastingEntry) -> Void) {
        completion(getEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<FastingEntry>) -> Void) {
        let entry = getEntry()
        // Refresh every 15 minutes
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private func getEntry() -> FastingEntry {
        let userDefaults = UserDefaults(suiteName: appGroupId)
        return FastingEntry(
            date: Date(),
            isFasting: userDefaults?.bool(forKey: "is_fasting") ?? false,
            planName: userDefaults?.string(forKey: "plan_name") ?? "",
            remainingTime: userDefaults?.string(forKey: "remaining_time") ?? "--:--:--",
            progress: userDefaults?.double(forKey: "progress") ?? 0,
            phaseName: userDefaults?.string(forKey: "phase_name") ?? ""
        )
    }
}

struct FastingWidgetEntryView: View {
    var entry: FastingEntry

    var body: some View {
        VStack(spacing: 6) {
            // Status
            Text(entry.isFasting ? "Fasting" : "Not Fasting")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(entry.isFasting ? Color(hex: "6C63FF") : .secondary)
                .textCase(.uppercase)
                .tracking(1)

            // Timer
            Text(entry.remainingTime)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .minimumScaleFactor(0.6)

            if entry.isFasting {
                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.white.opacity(0.1))
                            .frame(height: 4)
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "6C63FF"), Color(hex: "00D2FF")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geo.size.width * CGFloat(entry.progress), height: 4)
                    }
                }
                .frame(height: 4)

                // Plan + Phase
                HStack {
                    Text(entry.planName)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                    Spacer()
                    Text(entry.phaseName)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(Color(hex: "00D2FF").opacity(0.8))
                }
            } else {
                Text("Tap to start fasting")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.4))
            }
        }
        .padding(16)
        .background(
            ContainerRelativeShape()
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "111127"), Color(hex: "0F0F1A")],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        )
    }
}

@main
struct FastingWidget: Widget {
    let kind: String = "FastingWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: FastingWidgetProvider()) { entry in
            FastingWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Fasting Timer")
        .description("Track your intermittent fasting progress.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    FastingWidgetEntryView(
        entry: FastingEntry(
            date: Date(),
            isFasting: true,
            planName: "16:8",
            remainingTime: "08:30:00",
            progress: 0.47,
            phaseName: "Fat Burning"
        )
    )
    .previewContext(WidgetPreviewContext(family: .systemSmall))
}
