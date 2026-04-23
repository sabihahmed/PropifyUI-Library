import SwiftUI

// MARK: - MAIN VIEW

public struct AuctionDetailsView: View {

    @State private var userMaxBid: String = "5000000"
    @State private var minIncrementAmounts: String = "60,000"
    @State private var autoBidEnabled: Bool = true
    @StateObject private var vm = PlaceBidViewModel()
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
                .foregroundColor(.ColorsTextPrimary)
                .font(.poppinsBold(size: 20))
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
                        PropertyCard(
                                   image: "",
                                   lot: "Lot 1:",
                                   title: "Waves - Villa Waves - Villa",
                                   estimate: "$3.5M",
                                   status: .active, // ✅ FIXED
                                   estimatePercentage: "45% below estimate"
                               )
                    }

                    if !isPriceExpanded {
                        CurrentBidView(
                            currentBidAmount: $vm.userBid,
                            minIncrementAmount: $minIncrementAmounts
                        )
                    }

                    YourBidView(yourBidAmount: $vm.userBid)
                    QuickBidButtonsView(
                        amounts: ["50K", "100K", "200K"],
                        selectedAmount: vm.selectedQuickBid,
                        isAutoBidEnabled: autoBidEnabled
                    ) { amount in
                        
                        withAnimation(.easeInOut(duration: 0.2)) {
                            vm.selectedQuickBid = amount
                        }
                        
                        vm.applyQuickBid(amount: amount)
                    }

                    AutoBidToggleView(isOn: $autoBidEnabled)

                    if autoBidEnabled {
                        YourMaxBidView(maxAmount: $userMaxBid)
                        BidDisclaimerView()
                    }

                    FinalPriceView(
                        isExpanded: $isPriceExpanded,
                        currentBid: $vm.userBid,
                        premium: $buyerPremium,
                        commission: $sellerCommission,
                        fees: $platformFees,
                        tax: $taxes,
                        total: $totalAmount
                    )

                    Spacer(minLength: 10)
                }.padding()
                
            }
            
            ConfirmBidButtonView()
            
            BidActionButtonView(
                autoBidEnabled: $autoBidEnabled,
                userBid: $vm.userBid
            )
            EditBidButtonView()
            
            
        }
    }
} // 🟢 MainView ENDS HERE XXXXXXXXXXXX 🟢

import SwiftUI

public struct EditBidButtonView: View {

    public init() {}

    public var body: some View {

        Button(action: {

            // 🔴 TODO: Add confirm bid action here later
            // e.g. confirmBidAPI()

        }) {
            Text("Edit Bid")
                .font(.poppinsSemiBold(size: 16))
                .foregroundColor(.ColorsTextPrimary)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.white)
                .cornerRadius(24)
                .padding(.vertical,18)
                .padding(.horizontal,32)
                .overlay(
                RoundedRectangle(cornerRadius: 24)
                .stroke(Color.ColorsStrokeDefault, lineWidth: 1)
                )
        }
        .padding(.horizontal)
        .background(Color.white)
    }
}


import SwiftUI

public struct ConfirmBidButtonView: View {

    public init() {}

    public var body: some View {

        Button(action: {

            // 🔴 TODO: Add confirm bid action here later
            // e.g. confirmBidAPI()

        }) {
            Text("Confirm Bid - $")
                .font(.poppinsSemiBold(size: 16))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.ColorsBackgroundError)
                .cornerRadius(24)
                .padding(.top, 20)
                .padding(.bottom, 10)
        }
        .padding(.horizontal)
        .background(Color.white)
    }
}
 
public struct BidActionButtonView: View {

    @Binding public var autoBidEnabled: Bool
    @Binding public var userBid: String

    public init(
        autoBidEnabled: Binding<Bool>,
        userBid: Binding<String>
    ) {
        self._autoBidEnabled = autoBidEnabled
        self._userBid = userBid
    }

    public var body: some View {

        Button(action: {

            // 🟢 LOCAL LOGIC ONLY (no API yet)

            if autoBidEnabled {
                enableAutoBidLocal()
            } else {
                placeBidLocal()
            }

        }) {
            Text(autoBidEnabled
                 ? "Enable Auto Bid"
                 : "Place Bid $\(userBid)")
                .font(.poppinsSemiBold(size: 16))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,minHeight: 56, maxHeight: 56, alignment: .center)
                .frame(height: 56)
                .background(Color.ColorsButtonPrimary)
                .cornerRadius(24)
                .padding(.top, 20)
                .padding(.bottom, 10)
        }
        .padding(.horizontal)
        .background(Color.white)
    }

    // MARK: - Local Logic (temporary)

    private func enableAutoBidLocal() {
        print("🟢 Auto Bid Enabled (Local)")
        autoBidEnabled = false // toggle simulation after enabling
    }

    private func placeBidLocal() {
        print("🟣 Placing Bid Locally: \(userBid)")
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
                    .font(.poppinsRegular(size: 14))
                    .foregroundColor(Color.ColorsTextSecondary)

                Text(currentBidAmount)
                    .font(.poppinsBold(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(Color.ColorsTextPrimary)

            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("Min increment")
                    .font(.poppinsRegular(size: 14))
                    .foregroundColor(Color.ColorsTextSecondary)
                    


                Text(minIncrementAmount)
                    .font(.poppinsBold(size: 16))
                    .foregroundColor(Color.ColorsTextPrimary)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .background(Color.ColorsBackgroundSecondary)
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
                .font(.poppinsMedium(size: 14))
                .foregroundColor(.ColorsTextPrimary)

            HStack(spacing: 0) {

                Text("$")
                    .frame(width: 50, height: 50)
                    .background(Color.ColorsBackgroundSecondary)

                TextField("1,750,000", text: $yourBidAmount)
                    .font(.poppinsRegular(size: 14))
                    .foregroundColor(.ColorsTextPrimary)
                    .padding(.leading, 12)
                    .keyboardType(.numberPad)
            }
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.ColorsStrokeDefault)
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
                .font(.poppinsMedium(size: 14))
                .foregroundColor(.ColorsTextPrimary)

            HStack(spacing: 0) {

                Text("$")
                    .frame(width: 50, height: 50)
                    .background(Color.ColorsBackgroundSecondary)

                TextField("5,000,000", text: $maxAmount)
                    .font(.poppinsRegular(size: 14))
                    .foregroundColor(.ColorsTextPrimary)
                    .padding(.leading, 12)
                    .keyboardType(.numberPad)
            }
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.ColorsStrokeDefault)
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
            .font(.poppinsRegular(size: 12))
            .foregroundColor(Color.ColorsTextBody)
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
                        .font(.poppinsMedium(size: 14))
                        .foregroundColor(.ColorsTextPrimary)

                    Spacer()

                    Image("arrowDown" ,bundle: .module)
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
                    .font(.poppinsBold(size: 14))
                    .foregroundColor(.ColorsTextPrimary)

                Spacer()

                Text("AED \(total)")
                    .font(.poppinsBold(size: 14))
                    .foregroundColor(.ColorsTextPrimary)
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
                .kerning(0.1)
                .font(.poppinsRegular(size: 14))
                .foregroundColor(.ColorsTextSecondary)

            Spacer()

            Text("$ \(value)")
                .font(.poppinsMedium(size: 14))
                .foregroundColor(.ColorsTextPrimary)
        }
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - QUICK BUTTONS
//////////////////////////////////////////////////////////////////
///
///

import Foundation
import SwiftUI

final class PlaceBidViewModel: ObservableObject {
    
    @Published var userBid: String = "1800000"
    @Published var selectedQuickBid: String? = nil
    
    // MARK: - Quick Bid Logic
    
    func applyQuickBid(amount: String) {
        
        let numericPart = amount.replacingOccurrences(of: "K", with: "")
        
        guard let increment = Int(numericPart) else { return }
        
        let currentClean = userBid.replacingOccurrences(of: ",", with: "")
        
        guard let current = Int(currentClean) else { return }
        
        let newValue = current + (increment * 1000)
        
        userBid = formatNumber(newValue)
    }
    
    // MARK: - Formatter
    
    private func formatNumber(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}

import SwiftUI

/// Single quick bid pill button.
/// Handles visual states only (selected / disabled).
struct QuickBidButton: View {
    
    let title: String
    let isSelected: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        
        Text("+ \(title)")
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(foregroundColor)
            .padding(.vertical, 20)
            .padding(.horizontal, 25)
            .background(backgroundColor)
            .overlay(border)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(isSelected ? 0 : 0.05),
                    radius: 5, x: 0, y: 2)
            .opacity(isDisabled ? 0.7 : 1)
            .onTapGesture {
                guard !isDisabled else { return }
                action()
            }
    }
    
    // MARK: - COLORS (UPDATED)
    
    private var foregroundColor: Color {
        if isDisabled {
            return Color.gray.opacity(0.8)   // dark gray text
        }
        return isSelected ? .ColorsTextPurple01 : .black
    }
    
    private var backgroundColor: Color {
        if isDisabled {
            return Color.gray.opacity(0.15)   // gray background
        }
        return isSelected ? Color.ColorsBackgroundLightPurple : .white
    }
    
    private var border: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(
                isDisabled ? Color.gray.opacity(0.3) :
                (isSelected ? Color.ColorsTextPurple01 : Color.gray.opacity(0.2)),
                lineWidth: 2
            )
    }
}
import SwiftUI

/// Horizontal scroll row for quick bid selection.
/// Does NOT contain business logic — only forwards selection.
public struct QuickBidButtonsView: View {
    
    let amounts: [String]
    let selectedAmount: String?
    let isAutoBidEnabled: Bool
    let onSelect: (String) -> Void
    
    public init(
        amounts: [String],
        selectedAmount: String?,
        isAutoBidEnabled: Bool,
        onSelect: @escaping (String) -> Void
    ) {
        self.amounts = amounts
        self.selectedAmount = selectedAmount
        self.isAutoBidEnabled = isAutoBidEnabled
        self.onSelect = onSelect
    }
    
    public var body: some View {
        
        HStack(spacing: 15) {
            
            ForEach(amounts, id: \.self) { amount in
                
                QuickBidButton(
                    title: amount,
                    isSelected: selectedAmount == amount,
                    isDisabled: isAutoBidEnabled
                ) {
                    onSelect(amount)
                }
            }
        }
        .padding(.horizontal)
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
                .font(.poppinsRegular(size: 14))
                .foregroundColor(.ColorsTextPrimary)
            
            Toggle("", isOn: $isOn)
                .labelsHidden()


            Spacer()

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
