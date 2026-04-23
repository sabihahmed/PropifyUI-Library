//
//  SwiftUIView 2.swift
//  
//
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 12) {
                    // Manually calling the rows (Hardcoded for now)
                    BroadcastRowView(
                        message: "Lot 1: Zenith Grand Suite is now closed. Congratulations to Amal Rashid!",
                        time: "Now"
                    )
                    
                    BroadcastRowView(
                        message: "Lot 1: Zenith Grand Suite is now closed. Congratulations to Amal Rashid!",
                        time: "Now"
                    )
                    
                    BroadcastRowView(
                        message: "Lot 1: Zenith Grand Suite is now closed. Congratulations to Amal Rashid!",
                        time: "Now"
                    )
                    
                    BroadcastRowView(
                        message: "Lot 1: Zenith Grand Suite is now closed. Congratulations to...",
                        time: "Now"
                    )
                    .opacity(0.5)
                }
                .padding()
                
                
            }
        }
    }
}


public struct BroadcastRowView: View {
    public let message: String
    public let time: String
    
    public init(message: String, time: String) {
        self.message = message
        self.time = time
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            //icon
            ZStack {
                Circle()
                    .fill(Color.ColorsAlertsBackgroundInfo)
                    .frame(width: 32, height: 32)
                
                Image("SpeakerIcon",bundle: .module)
                    .foregroundColor(.blue)
                    .font(.system(size: 16))
            }
            
            // Middle Text
            Text(message)
                .font(.poppinsMedium(size: 14))
                .foregroundColor(.ColorsTextPrimary)
                .lineSpacing(4)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            // Right Text (Time)
            Text(time)
                .padding(.top)
                .font(.poppinsRegular(size: 12))
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.ColorsStrokeDefault, lineWidth: 1)
        )
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
