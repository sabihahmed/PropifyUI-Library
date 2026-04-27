import SwiftUI

// MARK: - MAIN VIEW

public struct AuctionView: View {
    @StateObject public var vm: AuctionViewModel

    public init(vm: AuctionViewModel = AuctionViewModel()) {
        _vm = StateObject(wrappedValue: vm)
    }

    public var body: some View {
        VStack(spacing: 20) {
            Spacer()

            PropertyCard(
                       image: "",
                       lot: "Lot 1:",
                       title: "Waves - Villa Waves - Villa",
                       estimate: "$3.5M",
                       status: .active, // ✅ FIXED
                       estimatePercentage: "45% below estimate"
                   )
            

            ZStack {

                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)

                VStack(spacing: 12) {

                    ForEach(Array(vm.bids.prefix(4).enumerated()), id: \.element.id) { index, bid in
                        BidRow(bid: bid, position: index)
                    }
                }
                .padding()
            }
            .frame(height: 280)
            .clipped()

            // 🔥 IMPROVED OVERLAY (MORE TRANSPARENT)
            .overlay(
                LinearGradient(
                    colors: [
                        Color.clear,
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.3),
                        Color.white.opacity(0.9)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
            LeadingAlert(state: .leading)
            LeadingAlert(state: .outOfLead)
            
            AlertContainerView(state: .used)
            AlertContainerView(state: .exceeded)

                

            PlaceBidAuctionHammerButton {
                vm.placeUserBid()
            }
            

        }
    }
}//🟢 MainView ENDS HERE XXXXXXXXXXXX


// MARK: - Color Helper

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)

        self.init(
            red: Double((rgb >> 16) & 0xFF) / 255,
            green: Double((rgb >> 8) & 0xFF) / 255,
            blue: Double(rgb & 0xFF) / 255
        )
    }
}

// MARK: - Model

public struct Bid: Identifiable {
    public let id: String
    public var amount: Int
    public var isUser: Bool
    public var status: BidStatus = .other

    public init(id: String, amount: Int, isUser: Bool, status: BidStatus = .other) {
        self.id = id
        self.amount = amount
        self.isUser = isUser
        self.status = status
    }
}

public enum BidStatus {
    case leading
    case outbid
    case other
}

// MARK: - ViewModel (UNCHANGED)

public class AuctionViewModel: ObservableObject {
    @Published public var bids: [Bid] = []

    public init() {
        bids = [
            Bid(id: "21", amount: 1650000, isUser: false),
            Bid(id: "22", amount: 1600000, isUser: false),
            Bid(id: "user", amount: 1500000, isUser: true)
        ]

        updateBids()
        startFakeBidding()
    }

    func updateBids() {
        bids.sort { $0.amount > $1.amount }

        guard let topId = bids.first?.id else { return }

        for i in 0..<bids.count {
            if bids[i].id == topId {
                bids[i].status = .leading
            } else if bids[i].isUser {
                bids[i].status = .outbid
            } else {
                bids[i].status = .other
            }
        }
    }

    func placeUserBid() {
        guard let top = bids.first else { return }

        withAnimation(.spring()) {
            if let index = bids.firstIndex(where: { $0.isUser }) {
                bids[index].amount = top.amount + Int.random(in: 20000...60000)
            } else {
                bids.append(
                    Bid(id: "user", amount: top.amount + 50000, isUser: true)
                )
            }
            updateBids()
        }
    }

    func startFakeBidding() {
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
            self.generateRandomBid()
        }
    }

    func generateRandomBid() {
        guard let top = bids.first else { return }

        let newBid = Bid(
            id: String(Int.random(in: 10...99)),
            amount: top.amount + Int.random(in: 10000...40000),
            isUser: false
        )

        withAnimation(.spring()) {
            bids.append(newBid)
            updateBids()
        }
    }
}
// --------------------------------------------------------------------------

// " MARK: Used 100% of your Limit Alerts, you've exceeded your limit alerts " 🚨🚨
import SwiftUI

public enum LimitState {
    case used
    case exceeded
    
    public var message: String {
        switch self {
        case .used:
            return "You've used 100% of your\nlimit"
        case .exceeded:
            return "You've exceeded your\nlimit"
        }
    }
}

public struct AlertContainerView: View {
    public let state: LimitState
    
    // REQUIRED: Public structs need an explicit public init to be visible to other modules
    public init(state: LimitState) {
        self.state = state
    }
    
    public var body: some View {
        HStack(alignment: .center) {
            Text(state.message)
                .font(.poppinsMedium(size: 14))
                    .foregroundColor(Color.ColorsTextWarning)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Button(action: {
                print("Increase limit tapped")
            }) {
                Text("Increase limit")
                    .font(.poppinsSemiBold(size: 12))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule().stroke(Color.ColorsStrokeDefault)
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.ColorsAlertsBackgroundErrorSubtle)
        .cornerRadius(16)
    }
}

// --------------------------------------------------------------------------

// Your'e Leading, Out of lead Custom Alert Boxes 🟢


public enum LeadState {
    case leading
    case outOfLead
}

public struct LeadingAlert: View {
    
    let state: LeadState
    
    public init(state: LeadState) {
        self.state = state
    }
    
    public var body: some View {
        HStack {
            iconView
            
            Text(title)
                .font(.poppinsSemiBold(size: 12))
        }
        .foregroundColor(foregroundColor)
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .background(backgroundColor)
        .cornerRadius(16)
    }
}

private extension LeadingAlert {
    
    var title: String {
        switch state {
        case .leading:
            return "You're Leading"
        case .outOfLead:
            return "Out of the Lead"
        }
    }
    
    var foregroundColor: Color {
        switch state {
        case .leading:
            return .ColorsAlertForeground
        case .outOfLead:
            return .ColorsTextWarning
        }
    }
    
    var backgroundColor: Color {
        switch state {
        case .leading:
            return .ColorsAlertsBackgroundSuccess
        case .outOfLead:
            return .ColorsAlertsBackgroundError
        }
    }
    
    @ViewBuilder
    var iconView: some View {
        switch state {
        case .leading:
            VStack(spacing: -4) {
                Image("arrowUp", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 8, height: 8)
                
                Image("arrowUp", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 8, height: 8)
            }
            
        case .outOfLead:
            Image("arrowsDown", bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
        }
    }
}


// // MARK: AuctionHammer PLaceBID button View 🟢


public struct PlaceBidAuctionHammerButton: View {
    
    private let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image("auctionHammer", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)

                Text("Place Bid")
                    .font(.poppinsBold(size: 22))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.ColorsButtonPrimary)
            .cornerRadius(96)
            .padding(.horizontal)
        }
    }
}

// MARK: - BID ROW

public struct BidRow: View {

    public let bid: Bid
    public let position: Int

    public init(bid: Bid, position: Int) {
        self.bid = bid
        self.position = position
    }

    var fontSize: CGFloat {
        switch position {
        case 0: return 26
        case 1: return 24
        case 2: return 20
        default: return 18
        }
    }

    var amountColor: Color {
        if bid.isUser {
            return bid.status == .leading
            ? Color(hex: "008236")
            : .gray
        } else {
            return position == 0
            ? Color(hex: "BB4D00")
            : .gray
        }
    }

    var rowBackground: Color {
        if bid.isUser {
            return bid.status == .leading
            ? Color(hex: "DCFCE7")
            : Color.gray.opacity(0.15)
        } else {
            return position == 0
            ? Color(hex: "FEF3C6")
            : Color.clear
        }
    }

    public var body: some View {
        HStack {

            // 🔥 LEFT CAPSULE (ONLY USER = "You")
            if bid.isUser {
                Text("You")
                    .font(.custom("Poppins-Regular", size: 14))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(hex: "FFE6FE"))
                    .overlay(
                        Capsule().stroke(Color(hex: "CA10B8"), lineWidth: 1)
                    )
                    .foregroundColor(Color(hex: "CA10B8"))
            } else {
                Text("#\(bid.id)")
                    .font(.custom("Poppins-Regular", size: 14))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.1))
                    .overlay(
                        Capsule().stroke(Color.gray, lineWidth: 1)
                    )
                    .foregroundColor(.gray)
            }

            Spacer()

            // 🔥 AMOUNT
            Text("$ \(bid.amount)")
                .font(.custom("Poppins-Bold", size: fontSize))
                .foregroundColor(amountColor)

            Spacer()

            // 🔥 TIME (ALL ROWS)
            Text("1 min")
                .font(.custom("Poppins-Regular", size: 12))
                .foregroundColor(.gray)
        }
        .padding()
        .background(rowBackground)
        .cornerRadius(96)
        .animation(.easeInOut(duration: 0.25), value: position)
    }
}

// MARK: - PREVIEW

public struct AuctionView_Previews: PreviewProvider {
    public static var previews: some View {
        AuctionView()
    }
}
