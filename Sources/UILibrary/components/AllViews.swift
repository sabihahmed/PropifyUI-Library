import SwiftUI

// MARK: - MAIN VIEW

public struct AuctionDetailsView: View {

    @State private var userBid: String = "1800000"
    @State private var userMaxBid: String = "5000000"
    @State private var minIncrementAmounts: String = "60,000"
    @State private var autoBidEnabled: Bool = true

    // 🟢 DROPDOWN CONTROL
    @State private var isPriceExpanded: Bool = false
    
    // 🟢 DATA BINDING FOR BREAKDOWN
    @State private var buyerPremium: String = "3,294"
    @State private var sellerCommission: String = "1,544"
    @State private var platformFees: String = "515"
    @State private var taxes: String = "53"
    @State private var totalAmount: String = "1,755,406"

    public init() {}

    public var body: some View {

        VStack(spacing: 0) {VStack(spacing: 6) {
            
            Text("Place a bid")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1)
        }

            // 🔷 SCROLLABLE CONTENT
            ScrollView {
                VStack(spacing: 20) {

                    if !isPriceExpanded {
                        PropertyCard(image: "villa1", lot: "Lot 1:", title: "Waves - Villa Waves - Villa", estimate: "$3.5M", status: "Status",estimatePercentage: "45% below estimate")

                    }

                    if !isPriceExpanded {
                        CurrentBidView(
                            currentBidAmount: $userBid,
                            minIncrementAmount: $minIncrementAmounts
                        )
                    }

                    YourBidView(yourBidAmount: $userBid)

                    QuickBidButtonsView { incrementAmount in
                        
                        // 🟢 LOCAL LOGIC
                        if let current = Int(userBid.replacingOccurrences(of: ",", with: "")) {
                            let newValue = current + incrementAmount
                            userBid = "\(newValue)"
                            
                            // 🟢 API CALL
                            // pushBidToServer(newValue)
                        }
                    }

                    AutoBidToggleView(isOn: $autoBidEnabled)

                    if autoBidEnabled {
                        YourMaxBidView(maxAmount: $userMaxBid)
                        BidDisclaimerView()
                    }

                    FinalPriceView(
                        isExpanded: $isPriceExpanded,
                        currentBid: $userBid,
                        premium: $buyerPremium,
                        commission: $sellerCommission,
                        fees: $platformFees,
                        tax: $taxes,
                        total: $totalAmount
                    )

                    Spacer(minLength: 10)
                }.padding()
                
            }
            

            // 🔥 FIXED BOTTOM BUTTON (no longer moves)
            Button(action: {

                // 🟢 API CALL
                if autoBidEnabled {
                    // enableAutoBidAPI()
                } else {
                    // placeBidAPI(userBid)
                }

            }) {
                Text(autoBidEnabled
                     ? "Enable Auto Bid"
                     : "Place Bid $\(userBid)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(Color(red: 0.8, green: 0.1, blue: 0.7))
                    .cornerRadius(27)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
            }
            .padding(.horizontal)
            .background(Color.white)
        }
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - CURRENT BID
//////////////////////////////////////////////////////////////////

public struct CurrentBidView: View {

    @Binding public var currentBidAmount: String
    @Binding public var minIncrementAmount: String

    public init(currentBidAmount: Binding<String>, minIncrementAmount: Binding<String>) {
        self._currentBidAmount = currentBidAmount
        self._minIncrementAmount = minIncrementAmount
    }

    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Current bid")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(currentBidAmount)
                    .font(.headline)
                    .fontWeight(.bold)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("Min increment")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(minIncrementAmount)
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .background(Color(appHex: "#F5F9FB"))
        .cornerRadius(16)
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - YOUR BID
//////////////////////////////////////////////////////////////////

public struct YourBidView: View {

    @Binding public var yourBidAmount: String

    public init(yourBidAmount: Binding<String>) {
        self._yourBidAmount = yourBidAmount
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text("Your Bid")
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack(spacing: 0) {

                Text("$")
                    .frame(width: 50, height: 50)
                    .background(Color(appHex: "#F5F9FB"))

                TextField("1,750,000", text: $yourBidAmount)
                    .padding(.leading, 12)
                    .keyboardType(.numberPad)
            }
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2))
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - MAX BID
//////////////////////////////////////////////////////////////////

public struct YourMaxBidView: View {

    @Binding public var maxAmount: String

    public init(maxAmount: Binding<String>) {
        self._maxAmount = maxAmount
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text("Your Max Bid")
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack(spacing: 0) {

                Text("$")
                    .frame(width: 50, height: 50)
                    .background(Color(appHex: "#F5F9FB"))

                TextField("5,000,000", text: $maxAmount)
                    .padding(.leading, 12)
                    .keyboardType(.numberPad)
            }
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2))
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - DISCLAIMER
//////////////////////////////////////////////////////////////////

public struct BidDisclaimerView: View {
    public init() {}
    public var body: some View {
        Text("We'll automatically bid on your behalf in increments of AED 50,000 up to your max.")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - FINAL PRICE (FIXED)
//////////////////////////////////////////////////////////////////

public struct FinalPriceView: View {

    @Binding public var isExpanded: Bool

    @Binding public var currentBid: String
    @Binding public var premium: String
    @Binding public var commission: String
    @Binding public var fees: String
    @Binding public var tax: String
    @Binding public var total: String

    public init(isExpanded: Binding<Bool>, currentBid: Binding<String>, premium: Binding<String>, commission: Binding<String>, fees: Binding<String>, tax: Binding<String>, total: Binding<String>) {
        self._isExpanded = isExpanded
        self._currentBid = currentBid
        self._premium = premium
        self._commission = commission
        self._fees = fees
        self._tax = tax
        self._total = total
    }

    public var body: some View {

        VStack(spacing: 0) {

            // 🔷 HEADER
            Button(action: {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text("Final price calculation")

                    Spacer()

                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .foregroundColor(.gray)
                }
                .padding()
            }

            // 🔷 DROPDOWN
            if isExpanded {
                PriceBreakdownView(
                    bid: currentBid,
                    premium: premium,
                    commission: commission,
                    fees: fees,
                    tax: tax,
                    total: total
                )
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(Color(appHex: "#F5F9FB")) // ✅ SINGLE BACKGROUND
        .cornerRadius(16)
        .clipped()
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - BREAKDOWN VIEW (FIXED)
//////////////////////////////////////////////////////////////////

public struct PriceBreakdownView: View {
    public var bid: String
    public var premium: String
    public var commission: String
    public var fees: String
    public var tax: String
    public var total: String
    public init(bid: String, premium: String, commission: String, fees: String, tax: String, total: String) {
        self.bid = bid
        self.premium = premium
        self.commission = commission
        self.fees = fees
        self.tax = tax
        self.total = total
    }

    public var body: some View {
        VStack(spacing: 15) {

            BreakdownRow(label: "Final price calculation", value: bid)
            BreakdownRow(label: "Buyer's premium", value: premium)
            BreakdownRow(label: "Seller commission", value: commission)
            BreakdownRow(label: "Platform fees", value: fees)
            BreakdownRow(label: "Taxes", value: tax)

            Divider()

            HStack {
                Text("Total")
                    .font(.headline)
                    .fontWeight(.bold)

                Spacer()

                Text("AED \(total)")
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
        .padding()
      
    }
}

public struct BreakdownRow: View {
    public var label: String
    public var value: String
    public init(label: String, value: String) {
        self.label = label
        self.value = value
    }

    public var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.gray)

            Spacer()

            Text("AED \(value)")
                .fontWeight(.semibold)
        }
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - QUICK BUTTONS
//////////////////////////////////////////////////////////////////

public struct QuickBidButtonsView: View {

    public var onTap: (Int) -> Void
    public init(onTap: @escaping (Int) -> Void) {
        self.onTap = onTap
    }

    let increments = [
        ("50K", 50000),
        ("100K", 100000),
        ("200K", 200000)
    ]

    public var body: some View {
        HStack(spacing: 10) {
            ForEach(increments, id: \.0) { label, value in
                Button {
                    onTap(value)
                } label: {
                    Text("+$ \(label)")
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .foregroundColor(.gray)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
            }
        }
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - TOGGLE
//////////////////////////////////////////////////////////////////

public struct AutoBidToggleView: View {

    @Binding public var isOn: Bool

    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }

    public var body: some View {
        HStack {
            Text("Auto bid")

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - COLOR EXTENSION
//////////////////////////////////////////////////////////////////

extension Color {
    init(appHex: String) {
        let hex = appHex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        self.init(
            .sRGB,
            red: Double((int >> 16) & 0xFF) / 255,
            green: Double((int >> 8) & 0xFF) / 255,
            blue: Double(int & 0xFF) / 255,
            opacity: 1
        )
    }
}

public struct AuctionDetailsView_Previews: PreviewProvider {
    public static var previews: some View {
        AuctionDetailsView()
    }
}
