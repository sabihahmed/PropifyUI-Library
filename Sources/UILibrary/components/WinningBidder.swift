import SwiftUI

// 1. Public Enum for the different states
public enum AuctionStatus {
    case winning
    case outbid
    case withdrawn
    
    public var text: String {
        switch self {
        case .winning: return "You're the winning bidder!"
        case .outbid: return "This lot went to another bidder"
        case .withdrawn: return "This property was withdrawn from auction"
        }
    }
    
    public var icon: String? {
        switch self {
        case .winning: return "trophy"
        default: return nil
        }
    }
    
    // MARK: - REPLACE WITH YOUR COLOR EXTENSION HERE
    public var primaryColor: Color {
        switch self {
        case .winning:
            return Color.ColorsAlertsTextOnSuccess
           // .Extension
        case .outbid:
            return Color.ColorsAlertsTextOnWarning
            // .Extension
        case .withdrawn:
            return Color.ColorsTextSecondary
            //.Extension
        }
    }
}

// 2. Public Reusable Component
public struct AuctionStatusField: View {
    public let status: AuctionStatus
    
    // Explicit public initializer
    public init(status: AuctionStatus) {
        self.status = status
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if let iconName = status.icon {
                Image(systemName: iconName)
                    .font(.system(size: 18, weight: .semibold))
            }
            
            Text(status.text)
                .font(.poppinsBold(size: 14))
                .kerning(0.1)
        }
        .foregroundColor(status.primaryColor)
        .padding(.horizontal, 16) 
        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
        // MARK: - REPLACE BACKGROUND COLOR HERE
        .cornerRadius(56)
        .shadow(
            color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.05),
            radius: 1, x: 0, y: 1
        )
        .overlay(
            RoundedRectangle(cornerRadius: 56)
                .inset(by: 0.5)
                .stroke(Color.ColorsStrokeDefault, lineWidth: 1)
        )
    }
}

// 3. Public Scene View
public struct AuctionSceneView: View {
    // Explicit public initializer
    public init() {}
    
    public var body: some View {
        VStack(spacing: 20) {
            AuctionStatusField(status: .winning)
            AuctionStatusField(status: .outbid)
            AuctionStatusField(status: .withdrawn)
        }
        .padding()
    }
}

// 4. Preview (Stays internal as it's for local testing)
struct AuctionStatus_Previews: PreviewProvider {
    static var previews: some View {
        AuctionSceneView()
            .previewLayout(.sizeThatFits)
    }
}
