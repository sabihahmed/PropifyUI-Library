import SwiftUI
import Foundation

// MARK: - Main View (✅ TIMER ADDED HERE)
public struct MainView: View {
    
    public init() {}
    
    // ✅ Mock data
    let broadcasts = mockBroadcasts()
    
    // ✅ THIS triggers UI refresh
    @State private var currentDate = Date()
    
    // ✅ Single timer for whole screen (every 60 sec)
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    public var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    
                    ForEach(broadcasts, id: \.timestamp) { item in
                        BroadcastRowView(
                            message: item.message,
                            timestamp: item.timestamp
                        )
                    }
                }
                .padding()
            }
        }
        // ✅ Every tick updates currentDate → forces re-render
        .onReceive(timer) { input in
            currentDate = input
        }
    }
}// Main View Ends here.



// MARK: - Mock API
public func mockBroadcasts() -> [(message: String, timestamp: String)] {
    let now = Date()
    
    func iso(_ secondsAgo: TimeInterval) -> String {
        let date = now.addingTimeInterval(-secondsAgo)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: date)
    }
    
    return [
        ("Just now", iso(180000)),
        ("10 minutes ago", iso(125)),
        ("1 hour ago", iso(3600)),
        ("2 hours ago", iso(7200)),
        ("Yesterday", iso(86400)),
        ("today", iso(86400)),
        ("Yesterday", iso(86400)),
        
    ]
}

// MARK: - Formatter
public func formatRelativeTime(from isoString: String) -> String {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [
        .withInternetDateTime,
        .withFractionalSeconds
    ]
    
    var date = isoFormatter.date(from: isoString)
    
    // fallback
    if date == nil {
        isoFormatter.formatOptions = [.withInternetDateTime]
        date = isoFormatter.date(from: isoString)
    }
    
    guard let validDate = date else {
        return "Invalid time"
    }
    
    // ✅ Optional: force "Just now"
    if Date().timeIntervalSince(validDate) < 60 {
        return "Just now"
    }
    
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    
    return formatter.localizedString(for: validDate, relativeTo: Date())
}

// MARK: - Row View
public struct BroadcastRowView: View {
    
    public let message: String
    public let timestamp: String
    
    public init(message: String, timestamp: String) {
        self.message = message
        self.timestamp = timestamp
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            ZStack {
                Circle()
                    .fill(Color.ColorsAlertsBackgroundInfo)
                    .frame(width: 32, height: 32)
                
                Image("SpeakerIcon", bundle: .module)
                    .foregroundColor(.blue)
                    .font(.system(size: 16))
            }
            
            Text(message)
                .font(.poppinsMedium(size: 14))
                .foregroundColor(.ColorsTextPrimary)
                .lineSpacing(0)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Text(formatRelativeTime(from: timestamp))
//                .padding()
                .font(.poppinsRegular(size: 12))
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.ColorsStrokeDefault, lineWidth: 1)
        )
    }
}

// MARK: - Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
