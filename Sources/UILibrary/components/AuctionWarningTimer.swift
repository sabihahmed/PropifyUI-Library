import SwiftUI
import Combine

class WarningTimerViewModel: ObservableObject {
    
    @Published var timeRemaining: Int = 10
    
    private var timer: AnyCancellable?
    
    init() {
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }
    
    func tick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timeRemaining = 10 // loop
        }
    }
    
    // MARK: - STATES
    
    var isLastCall: Bool {
        timeRemaining <= 3
    }
    
    var message: String {
        switch timeRemaining {
        case 7...10:
            return "Fair warning: Going Once"
        case 4...6:
            return "Fair warning: Going Twice"
        case 0...3:
            return "Fair warning: Last Call"
        default:
            return ""
        }
    }
    
    // ✅ ONE continuous progress (NO RESET)
    var progress: Double {
        return Double(timeRemaining) / 10.0
    }
}

import SwiftUI

struct CircularTimerView: View {
    
    var progress: Double
    var color: Color
    
    private let lineWidth: CGFloat = 3
    
    var body: some View {
        ZStack {
            
            // ✅ Gray base (inset manually)
            Circle()
                .inset(by: lineWidth / 2)
                .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
            
            // ✅ Animated stroke (same inset = PERFECT ALIGNMENT)
            Circle()
                .inset(by: lineWidth / 2)
                .trim(from: 0, to: progress)
                .stroke(color, lineWidth: lineWidth)
                .rotationEffect(Angle.degrees(-90)) // ✅ FIXED
                //.animation(Animation.default, value: progress) // ✅ FIXED
        }
        .frame(width: 24, height: 24)
    }
}
struct WarningBadgeView: View {
    
    var count: Int
    var message: String
    var isLastCall: Bool
    var progress: Double
    
    var body: some View {
        
        let strokeColor = isLastCall ? Color.warningRed : Color.warningPink
        let textColor = strokeColor
        let bgColor = isLastCall ? Color.warningRedBg : Color.warningPinkBg
        
        HStack(spacing: 6) {
            
            ZStack {
                CircularTimerView(
                    progress: progress,
                    color: strokeColor // ✅ changes color only
                )
                
                Text("\(count)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(textColor)
            }
            
            Text(message)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(textColor)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(bgColor)
        .overlay(
            Capsule()
                .stroke(strokeColor, lineWidth: 1.2)
        )
        .clipShape(Capsule())
    }
}

struct WarningContainerView: View {
    
    @StateObject private var vm = WarningTimerViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            
            WarningBadgeView(
                count: vm.timeRemaining,
                message: vm.message,
                isLastCall: vm.isLastCall,
                progress: vm.progress
            )
            
            if vm.timeRemaining == 0 {
                Text("🔔 Next Alert Placeholder")
                    .font(.caption)
            }
        }
        .padding()
    }
}
import SwiftUI

extension Color {
    static let warningPink = Color(hex2: "#FF4DB8")
    static let warningPinkBg = Color(hex2: "#FF4DB8").opacity(0.12)
    
    static let warningRed = Color(hex2: "#FF3B30")
    static let warningRedBg = Color(hex2: "#FF3B30").opacity(0.12)
}

extension Color {
    init(hex2: String) {
        let hex = hex2.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r, g, b: UInt64
        (r, g, b) = ((int >> 16) & 255, (int >> 8) & 255, int & 255)
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
}

struct WarningContainerView_Previews: PreviewProvider {
    static var previews: some View {
        WarningContainerView()
    }
}

