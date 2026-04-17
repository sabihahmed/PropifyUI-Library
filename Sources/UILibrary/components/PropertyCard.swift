//
//  PropertyCard.swift
//  UiComponents
//

import SwiftUI


public struct PropertyCard: View {
    public var image : String
    public var lot : String
    public var title : String
    public var estimate : String
    public var status : String
    public var estimatePercentage: String
    public var propertyType: String = "Villa"
    // Public initializer
    public init(image: String, lot: String, title: String, estimate: String, status: String, estimatePercentage: String) {
        self.image = image
        self.lot = lot
        self.title = title
        self.estimate = estimate
        self.status = status
        self.estimatePercentage = estimatePercentage
    }
    
    public var body: some View {
        
        // 👇 Added alignment: .top here
        HStack(alignment: .top, spacing: 12){
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56, alignment: .topLeading)
                .clipped()
                .cornerRadius(10)
            
            
            
            VStack(alignment: .leading, spacing: 4){
                
                HStack{
                    Text(lot)
                        .font(.poppinsMedium(size: 14))
                        .foregroundColor(Color.Text.Primary)
                        .lineLimit(1)
                        .truncationMode(.middle)
                    
                    Text(title)
                        .font(.poppinsMedium(size: 14))
                        .lineLimit(1)
                    
                    Text(propertyType) // 🆕 ADDED
                        .font(.poppinsMedium(size: 14))
                        .lineLimit(1)
                }

                Text("Propify Estimate: \(estimate)")
                    .font(.poppinsMedium(size: 12))
                    .kerning(0.3)
                    .foregroundColor(.ColorsTextSecondary)

                
                HStack{
                    Text(status)
                        .font(.poppinsSemiBold(size: 12))
                        .padding(.horizontal,10)
                        .padding(.vertical,2)
                        .frame(height: 20, alignment: .leading)
                        .background(Color.ColorsAlertsBackgroundSuccess)
                        .foregroundColor(.ColorsAlertForeground)
                        .cornerRadius(16)
                    
                    Text(estimatePercentage)
                        .font(.poppinsSemiBold(size: 12))
                        .font(.caption)
                        .padding(.horizontal,10)
                        .padding(.vertical,2)
                        .frame(height: 20, alignment: .leading)
                        .background(Color.ColorsAlertsBackgroundSuccess)
                        .foregroundColor(.ColorsAlertForeground)
                        .cornerRadius(16)
                    
                  

                }.padding(.top,3)
            }
            Spacer()
            
            Image("infoSymbol" ,bundle: .module)
                .resizable()           // Allows the vector to change size
                .scaledToFit()         // Keeps the original aspect ratio
                .frame(width: 18, height: 18)
                .padding(.top,22) // 🟡 ADDED (better vertical alignment)
                .padding(.horizontal,10)
            // Set yourdesired size
            
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.05), radius: 1, x: 1, y: 1)
        .overlay(
        RoundedRectangle(cornerRadius: 16)
        .inset(by: 0.5)
        .stroke(Color.ColorsStrokeDefault, lineWidth: 1)
    )
   }
}

//public struct CustomTextBox: View {
//    // Defining your custom colors
//    public let textColor: Color
//    public let backgroundColor: Color
//
//    public init(textColor: Color = Color(red: 0/255, green: 130/255, blue: 54/255), backgroundColor: Color = Color(red: 220/255, green: 252/255, blue: 231/255)) {
//        self.textColor = textColor
//        self.backgroundColor = backgroundColor
//    }
//
//    public var body: some View {
//        Text(">> You're Leading")
//            .font(.custom("Poppins-Bold", size: 18))
//            .foregroundColor(textColor)
//            .fontWeight(.heavy)
//            .padding(.horizontal, 40)
//            .padding(.bottom,10)
//            .padding(.top,10)
//            .background(backgroundColor)
//            .cornerRadius(96)
//    }
//}

public struct PropertyCard_Previews: PreviewProvider {
    public static var previews: some View {
        PropertyCard(image: "", lot: "Lot 1:", title: "Waves - Villa Waves - Villa ", estimate: "$3.5M", status: "Status",estimatePercentage: "45% below estimate")
    }
}
