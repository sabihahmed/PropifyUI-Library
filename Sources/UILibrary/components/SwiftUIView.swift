//
//  SwiftUIView.swift
//  UILibrary
//
//  Created by Sabih Ahmed on 06/05/2026.
//

//
//  UiComponents
//

import SwiftUI

public enum PropertyStatus2{
    case active
    case closed
    case upcoming
    case boughtIn
}

public extension PropertyStatus2 {
    
    var title: String {
        switch self {
        case .active: return "Active"
        case .closed: return "Closed"
        case .upcoming: return "Upcoming"
        case .boughtIn: return "Bought In"
        }
    }
    
    // MARK: - Placeholder Colors (replace with your design system)
    
    var backgroundColor: Color {
        switch self {
        case .active:
            return Color.ColorsAlertsBackgroundSuccess // replace
        case .closed:
            return Color.ColorsBackgroundSecondary // replace
        case .upcoming:
            return Color.ColorsBackgroundInfo2 // replace
        case .boughtIn:
            return Color.ColorsAlertsBackgroundErrorSubtle // replace
        }
    }
    
    var textColor: Color {
        switch self {
        case .active:
            return Color.ColorsGreenForeground // replace
        case .closed:
            return Color.ColorsTextSecondary // replace
        case .upcoming:
            return Color.ColorsAlertsTextOnInfo // replace
        case .boughtIn:
            return Color.ColorsTextWarning // replace
        }
    }
}
// oooooo
import SwiftUI

public struct StatusChip2: View {
    
    public var status: PropertyStatus
    
    public init(status: PropertyStatus) {
        self.status = status
    }
    
    public var body: some View {
        Text(status.title)
            .font(.poppinsSemiBold(size: 12))
            .padding(.horizontal, 10)
            .padding(.vertical, 2)
            .frame(height: 20)
            .background(status.backgroundColor)
            .foregroundColor(status.textColor)
            .cornerRadius(16)
    }
}

import SwiftUI

import SwiftUI

public struct PropertyCard2: View {
    
    public var image: String
    public var lot: String
    public var title: String
    public var estimate: String
    public var status: PropertyStatus
    public var estimatePercentage: String
    public var propertyType: String = ""
    
    public init(image: String,
                lot: String,
                title: String,
                estimate: String,
                status: PropertyStatus,
                estimatePercentage: String,
                propertyType: String = "") {
        
        self.image = image
        self.lot = lot
        self.title = title
        self.estimate = estimate
        self.status = status
        self.estimatePercentage = estimatePercentage
        self.propertyType = propertyType
    }
    
    public var body: some View {
        
        HStack(alignment: .center, spacing: 12) {
            
            // MARK: - Image (CHANGED: using asset from module bundle)
            Image("villa1", bundle: .module)
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipped()
                .cornerRadius(10)
            
            // MARK: - Content
            VStack(alignment: .leading, spacing: 4) {
                
                HStack {
                    Text(lot)
                        .font(.poppinsMedium(size: 14))
                        .foregroundColor(Color.Text.Primary)
                        .lineLimit(1)
                        .truncationMode(.middle)
                    
                    Text(title)
                        .font(.poppinsMedium(size: 14))
                        .lineLimit(1)
                }
                
                Text("Propify Estimate: \(estimate)")
                    .font(.poppinsMedium(size: 12))
                    .kerning(0.3)
                    .foregroundColor(.ColorsTextSecondary)
                
                HStack(spacing: 8) {
                    StatusChip(status: status)
                    TextualChip(text: "Placeholder", state: .red)
                }
                .padding(.top, 3)
            }
            .padding(.trailing, 24) // CHANGED: added trailing padding to create space for info icon
            
            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 1, x: 1, y: 1)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        // CHANGED: info icon placed via overlay, vertically centered, trailing edge
        .overlay(alignment: .trailing) {
            Image("infoSymbol", bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .padding(.trailing, 16)
        }
    }
}

public struct PropertyCard2_Previews: PreviewProvider {
    public static var previews: some View {
        PropertyCard2(
            image: "villa1",
            lot: "Lot 1:",
            title: "Waves - Villa Waves - Villa",
            estimate: "$3.5M",
            status: .upcoming, // ✅ FIXED
            estimatePercentage: "45% below estimate"
        )
        .previewLayout(.sizeThatFits)
    }
}

