//
//  SwiftUIView.swift
//  UILibrary
//
//  Created by Sabih Ahmed on 07/05/2026.
//

import SwiftUI

public enum BidButtonStyle {
    case placeBid
    case placeBidDisabled
    case confirmBid(currency: String, amount: String)
    case enableAutoBid
    case placeBidWithAmount(currency: String, amount: String)
    case editBid
}

public struct BidButton: View {

    public var style: BidButtonStyle
    public var action: () -> Void

    public init(style: BidButtonStyle, action: @escaping () -> Void) {
        self.style = style
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            content
        }
        .disabled(isDisabled)
    }

    @ViewBuilder
    private var content: some View {
        switch style {
        case .placeBid:
            HStack(alignment: .center, spacing: 8) {
                Image("auctionHammer", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                Text("Place Bid")
                    .font(.poppinsBold(size: 16))
                    .foregroundColor(.ColorsTextInverted)
            }
            .padding(.horizontal, 46)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.white)
            .background(Color.ColorsButtonPrimary)
            .cornerRadius(96)

        case .placeBidDisabled:
            HStack(alignment: .center, spacing: 8) {
                Image("auctionHammer", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                Text("Place Bid")
                    .font(.poppinsBold(size: 16))
                    .foregroundColor(.ColorsTextInverted)
            }
            .padding(.horizontal, 46)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.white)
            .background(Color.ColorsButtonDisabled)
            .cornerRadius(96)

        case .confirmBid(let currency, let amount):
            HStack(alignment: .center, spacing: 4) {
                Text("Confirm Bid – \(currency) \(amount)")
                    .font(.poppinsBold(size: 16))
                    .foregroundColor(.ColorsTextInverted)

            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
            .foregroundColor(.white)
            .background(Color.ColorsBackgroundError)
            .cornerRadius(96)

        case .enableAutoBid:
            HStack(alignment: .center, spacing: 4) {
                Text("Enable Auto Bid")
                    .font(.poppinsBold(size: 16))
                    .foregroundColor(.ColorsTextInverted)

            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
            .foregroundColor(.white)
            .background(Color.ColorsButtonPrimary)
            .cornerRadius(96)

        case .placeBidWithAmount(let currency, let amount):
            HStack(alignment: .center, spacing: 4) {
                Text("Place Bid – \(currency) \(amount)")
                    .font(.poppinsBold(size: 16))
                    .foregroundColor(.ColorsTextInverted)

            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
            .foregroundColor(.white)
            .background(Color.ColorsButtonPrimary)
            .cornerRadius(96)

        case .editBid:
            HStack(alignment: .center, spacing: 4) {
                Text("Edit Bid")
                    .font(.poppinsBold(size: 16))
                    .foregroundColor(.ColorsTextPrimary)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.ColorsTextPrimary)
            .cornerRadius(96)
            .overlay(
                RoundedRectangle(cornerRadius: 96)
                    .inset(by: 0.5)
                    .stroke(Color.ColorsStrokeDefault, lineWidth: 1)
            )
        }
    }

    private var isDisabled: Bool {
        if case .placeBidDisabled = style { return true }
        return false
    }
}

public struct BidButton_Previews: PreviewProvider {
    public static var previews: some View {
        VStack(spacing: 16) {
            BidButton(style: .placeBid) {}
            BidButton(style: .placeBidDisabled) {}
            BidButton(style: .confirmBid(currency: "$", amount: "1,750,000")) {}
            BidButton(style: .enableAutoBid) {}
            BidButton(style: .placeBidWithAmount(currency: "$", amount: "1,750,000")) {}
            BidButton(style: .editBid) {}
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
