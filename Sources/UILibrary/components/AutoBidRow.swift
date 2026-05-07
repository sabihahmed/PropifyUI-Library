//
//  SwiftUIView.swift
//  UILibrary
//
//  Created by Sabih Ahmed on 06/05/2026.
//

import SwiftUI

public struct AutoBidRow: View {

    @Binding public var isAutoBidEnabled: Bool
    public var maxBidAmount: String
    public var currency: String

    public init(isAutoBidEnabled: Binding<Bool>,
                maxBidAmount: String,
                currency: String) {
        self._isAutoBidEnabled = isAutoBidEnabled
        self.maxBidAmount = maxBidAmount
        self.currency = currency
    }

    public var body: some View {
        HStack {
            
            // ✅ CHANGED: Custom circular toggle
            Button {
                isAutoBidEnabled.toggle()
            } label: {
                ZStack(alignment: isAutoBidEnabled ? .trailing : .leading) {
                    Capsule()
                        .fill(isAutoBidEnabled ? Color.green : Color.gray.opacity(0.3))
                        .frame(width: 40, height: 24)

                    Circle()
                        .fill(Color.white)
                        .frame(width: 22, height: 22)
                        .shadow(color: Color(red: 0.14, green: 0.37, blue: 0.25).opacity(0.3), radius: 4, x: 0, y: 2)
                        .padding(2)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: isAutoBidEnabled)
            Text("Auto Bid")
                .font(.poppinsBold(size: 16))
                .foregroundColor(.ColorsTextPrimary)


            Spacer()

            HStack(spacing: 4) {
                Text("Max bid:")
                    .font(.poppinsRegular(size: 14))
                    .foregroundColor(.ColorsTextSecondary)
                    .kerning(0.1)

                Text("\(currency) \(maxBidAmount)")
                    .font(.poppinsBold(size: 14))
                    .foregroundColor(.ColorsTextPrimary)
                    .kerning(0.1)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.05), radius: 1, x: 0, y: 1)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color.ColorsStrokeDefault, lineWidth: 1)
        )
    }
}


public struct AutoBidRow_Previews: PreviewProvider {
    public static var previews: some View {
        AutoBidRow(
            isAutoBidEnabled: .constant(true),
            maxBidAmount: "3,000,000",
            currency: "₿"
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
