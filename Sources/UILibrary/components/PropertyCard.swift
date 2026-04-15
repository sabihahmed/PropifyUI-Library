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
                .frame(width: 56, height: 56)
                .clipped()
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4){
                
                HStack{
                    Text(lot)
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Text(title)
                        .font(.headline)
                        .lineLimit(1)
                }

                Text("Propify Estimate: \(estimate)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                
                HStack{
                    Text(status)
                        .font(.caption)
                        .padding(.horizontal,8)
                        .padding(.vertical,4)
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.green)
                        .cornerRadius(6)
                    
                    Text(estimatePercentage)
                        .font(.caption)
                        .padding(.horizontal,8)
                        .padding(.vertical,4)
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.green)
                        .cornerRadius(6)
                }
            }
            Spacer()
            
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 1)
    }
}

struct CustomTextBox: View {
    // Defining your custom colors
    let textColor = Color(red: 0/255, green: 130/255, blue: 54/255)       // #008236
    let backgroundColor = Color(red: 220/255, green: 252/255, blue: 231/255) // #DCFCE7

    var body: some View {
        Text(">> You're Leading")
            .font(.custom("Poppins-Bold", size: 18)) // Using the Poppins font you installed
            .foregroundColor(textColor)
            .fontWeight(.heavy)
            .padding(.horizontal, 40)
            .padding(.bottom,10)
            .padding(.top,10)// Space on the sides
             // Space on the top/bottom
            .background(backgroundColor)
            .cornerRadius(96)         // Your specific corner radius
    }
}

struct PropertyCard_Previews: PreviewProvider {
    static var previews: some View {
        PropertyCard(image: "villa1", lot: "Lot 1:", title: "Waves - Villa Waves - Villa", estimate: "$3.5M", status: "Status",estimatePercentage: "45% below estimate")
    }
}
