import SwiftUI
import Combine

// MARK: - VIEW MODEL

public class BiddingStartTimerViewModel: ObservableObject {
    
    @Published public var timeRemaining: Int
    @Published public var isVisible: Bool = true
    
    private var totalDuration: Int
    private var timer: AnyCancellable?
    
    public init(duration: Int = 10) {
        self.totalDuration = duration
        self.timeRemaining = duration
        startLoop()
    }
    
    private func startLoop() {
        timer?.cancel()
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }
    
    private func tick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            // ✅ LOOP
            timeRemaining = totalDuration
        }
    }
    
    public var progress: Double {
        Double(timeRemaining) / Double(totalDuration)
    }
}

// MARK: - CIRCULAR TIMER

struct BlueCircularTimerView: View {
    
    var progress: Double
    
    private let lineWidth: CGFloat = 2
    
    var body: some View {
        ZStack {
            
            Circle()
                .inset(by: lineWidth / 2)
                .stroke(Color.ColorsBackgroundInfo2, lineWidth: lineWidth)
            
            Circle()
                .inset(by: lineWidth / 2)
                .trim(from: 0, to: progress)
                .stroke(Color.ColorsAlertsTextOnInfo, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 0.9), value: progress)
        }
        .frame(width: 24, height: 24)
    }
}

// MARK: - MAIN BADGE

public struct BiddingStartingBadgeView: View {
    
    @ObservedObject var vm: BiddingStartTimerViewModel
    
    public init(vm: BiddingStartTimerViewModel) {
        self.vm = vm
    }
    
    public var body: some View {
        
        if vm.isVisible {
            HStack(spacing: 8) {
                
                ZStack {
                    BlueCircularTimerView(progress: vm.progress)
                    
                    Text("\(vm.timeRemaining)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.ColorsAlertsTextOnInfo)
                }
                
                Text("Bidding starting...")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.ColorsAlertsTextOnInfo)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white)
            .overlay(
                Capsule()
                    .stroke(Color.ColorsStrokeDefault, lineWidth: 1)
            )
            .clipShape(Capsule())
            .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.05), radius: 1, x: 0, y: 1)

        }
    }
}

// MARK: - PREVIEW

struct BiddingStartingBadgeView_Previews: PreviewProvider {
    
    static var previews: some View {
        BiddingStartingBadgeView(
            vm: BiddingStartTimerViewModel(duration: 10)
        )
        .previewLayout(.sizeThatFits)
        .padding()
//        .background(Color.gray.opacity(0.1))
    }
}
