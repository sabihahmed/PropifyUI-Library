import SwiftUI

public struct PropertyData {
    public let imageName: String = "villa1"
    public let status1: String = "Off-Plan"
    public let status2: String = "Upcoming"
    public let lot: String = "LOT 2"
    public let propertyName: String = "Waves Premium"
    public let propertyType: String = "Villa"
    public let location: String = "Al Rayyan Community, Abu Dhabi"
    public let beds: String = "2 Beds"
    public let baths: String = "3 Baths"
    public let sqft: String = "1,234 sqft"
    public let estimateValue: String = "3,100,000"
    
    public init() {}
}

public struct PropertySheetView: View {
    let data = PropertyData()
    
    public init() {}

    public var body: some View {
        VStack(spacing: 20) {
            // 1. Image with Badges
            ZStack(alignment: .topLeading) {
                Image(data.imageName, bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                HStack(spacing: 8) {
                    Text(data.status1)
                        .font(.poppinsSemiBold(size: 12))
                        .foregroundColor(.ColorsTextSecondary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.ColorsButtonSecondary.opacity(0.9))
                        .cornerRadius(16)
                        .kerning(0.2)

                    
                    Text(data.status2)
                        .font(.poppinsSemiBold(size: 12))
                        .foregroundColor(.ColorsAlertsTextOnInfo)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.ColorsButtonSecondary.opacity(0.9))
                        .cornerRadius(16)
                        .kerning(0.2)

                }
                .padding()
            }
            
            // 2. Title & Location
            VStack(alignment: .leading, spacing: 4) {
                Text("\(data.lot): \(data.propertyName) – \(data.propertyType)")
                    .font(.poppinsBold(size: 16))
                    .foregroundColor(.ColorsTextPrimary)
                
                Text(data.location)
                    .font(.poppinsRegular(size: 12))
                    .foregroundColor(.ColorsTextSecondary)
                    .kerning(0.1)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // 3. Stats Row (Beds, Baths, Sqft)
            HStack {
                statItem(icon: "bedIcon", label: data.beds)
                Divider().frame(height: 20).padding(.horizontal, 5)
                statItem(icon: "bathIcon", label: data.baths)
                Divider().frame(height: 20).padding(.horizontal, 5)
                statItem(icon: "rulerIcon", label: data.sqft)
            }
            
            // 4. Propify Estimate Box
            VStack(spacing: 4) {
                Text("Propify Estimate")
                    .font(.poppinsMedium(size: 14))
                    .foregroundColor(.ColorsTextSecondary)
                    .kerning(0.2)

                Text("$ \(data.estimateValue)")
                    .font(.poppinsRegular(size: 16))
                    .foregroundColor(.ColorsTextPrimary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.ColorsBackgroundSecondary)
            .cornerRadius(16)
            
            // 5. View All Details Button
            Button(action: { /* Action here */ }) {
                HStack {
                    Text("View all details")
                        .font(.poppinsBold(size: 14))
                        .foregroundColor(.ColorsTextPrimary)
                        .kerning(0.1)

                    Image("arrowRight",bundle: .module)
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(
                    Capsule().stroke(Color.ColorsStrokeDefault, lineWidth: 1)
                )
            }
            
            Spacer()
        }
        .padding(.top,20)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.white)
            // Manually forcing extra rounding at the top of the content
            .cornerRadius(30, corners: [.topLeft, .topRight])
    }
    
    // Helper for the small stats icons
    @ViewBuilder
    private func statItem(icon: String, label: String) -> some View {
        HStack(spacing: 5) {
            Image(icon, bundle: .module)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .foregroundColor(.ColorsTextSecondary)
            Text(label)
                .font(.poppinsRegular(size: 14))
                .foregroundColor(.ColorsTextSecondary)
        }
    }
}

struct MainView2: View {
    @State private var showingPropertySheet = false
    
    var body: some View {
        VStack {
            Button(action: {
                showingPropertySheet.toggle()
            }) {
                Text("Show Property Sheet")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $showingPropertySheet) {
            PropertySheetView()
                // Available in Xcode 14.2+ / iOS 16+
                // This makes it a partial bottom sheet
                .presentationDetents([.fraction(0.65), .large])
                .presentationDragIndicator(.visible)
        }
    }
}

// Helper to round specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}





struct MainView2_Previews: PreviewProvider {
    static var previews: some View {
        MainView2()
    }
}
