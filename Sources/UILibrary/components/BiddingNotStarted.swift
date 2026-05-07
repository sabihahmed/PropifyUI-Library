//
//  SwiftUIView.swift
//  UILibrary
//
//  Created by Sabih Ahmed on 07/05/2026.
//

import SwiftUI

public struct BiddingNotStartedView: View {

    public var title: String
    public var subtitle: String

    public init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }

    public var body: some View {
        VStack(spacing: 12) {

            // ✅ Circle with icon
            HStack(alignment: .center, spacing: 8) {
                Image("grayHammer", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }
            .padding(16)
            .background(Color.ColorsBackgroundSecondary)
            .cornerRadius(48)

            // ✅ Title
            Text(title)
                .font(.poppinsMedium(size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(.ColorsTextPrimary)
                .frame(maxWidth: .infinity, alignment: .top)

            // ✅ Subtitle
            Text(subtitle)
                .kerning(0.1)
                .font(.poppinsRegular(size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(.ColorsTextSecondary)
                .frame(maxWidth: .infinity, alignment: .top)
        }
        .padding(24)
    }
}

public struct BiddingNotStartedView_Previews: PreviewProvider {
    public static var previews: some View {
        BiddingNotStartedView(
            title: "Bidding hasn't started yet",
            subtitle: "This lot is upcoming and will open for bids soon"
        )
        .previewLayout(.sizeThatFits)
    }
}
