//
//  SwiftUIView.swift
//
//
//  Created by Sabih_Ahmed on 28/04/2026.
//

import SwiftUI

struct StartingInfoBar: View {
    // MARK: - Public Properties
    var tagText: String
    var amountText: String
    var currencySymbol: String
    var timeText: String
    
    // Theme Colors
    var backgroundColor: Color = Color(red: 0.96, green: 0.98, blue: 0.99)
    var tagBackgroundColor: Color = .white
    var tagTextColor: Color = Color(red: 0.35, green: 0.45, blue: 0.5)
    var amountTextColor: Color = .black
    var timeTextColor: Color = Color(red: 0.45, green: 0.55, blue: 0.6)

    var body: some View {
        HStack {
            // Left Tag
            Text(tagText)
                .font(.poppinsSemiBold(size: 12))
                .foregroundColor(Color.ColorsTextSecondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(Color.ColorsTagsSilver)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                )
                .overlay(
                    Capsule()
                        .stroke(Color.ColorsStrokeMedium, lineWidth: 1)
                )

            Spacer()

            // Center Amount
            HStack(spacing: 6) {
                Text(currencySymbol)
                    .font(.system(size: 26, weight: .light)) // Matches the thin currency look
                
                Text(amountText)
                    .font(.system(size: 26, weight: .heavy))
            }
            .foregroundColor(Color.ColorsTextPrimary)

            Spacer()

            // Right Time
            Text(timeText)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color.ColorsTextSecondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Capsule().fill(backgroundColor))
    }
}

// MARK: - Preview
struct StartingInfoBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // Default usage
            
            // Customized usage example
            StartingInfoBar(
                tagText: "Current",
                amountText: "2,500,000",
                currencySymbol: "$",
                timeText: "12 mins",
                backgroundColor: Color.ColorsButtonSecondary
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
