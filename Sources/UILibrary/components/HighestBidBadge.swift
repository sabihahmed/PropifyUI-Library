//
//  SwiftUIView.swift
//  UILibrary
//
//  Created by Sabih Ahmed on 07/05/2026.
//

import SwiftUI

public enum HighestBidBadgeStyle {
    case success
    case warning

    var backgroundColor: Color {
        switch self {
        case .success: return .ColorsAlertsBackgroundSuccess
        case .warning: return .ColorsAlertsBackgroundWarning
        }
    }

    var textColor: Color {
        switch self {
        case .success: return .ColorsAlertsTextOnSuccess
        case .warning: return .ColorsAlertsTextOnWarning
        }
    }
}

public struct HighestBidBadge: View {

    public var style: HighestBidBadgeStyle
    public var currency: String
    public var amount: String

    public init(style: HighestBidBadgeStyle, currency: String, amount: String) {
        self.style = style
        self.currency = currency
        self.amount = amount
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Text("Highest: \(currency) \(amount)")
                .font(.poppinsRegular(size: 12))
                .kerning(0.2)
                .foregroundColor(style.textColor)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 0)
        .frame(width: 184, height: 30, alignment: .center)
        .background(style.backgroundColor)
        .cornerRadius(16)
    }
}

public struct HighestBidBadge_Previews: PreviewProvider {
    public static var previews: some View {
        VStack(spacing: 20) {
            HighestBidBadge(style: .warning, currency: "$", amount: "1,700,000")
            HighestBidBadge(style: .success, currency: "₿", amount: "1,700,000")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
