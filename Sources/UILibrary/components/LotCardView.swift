//
//  SwiftUIView.swift
//  UILibrary
//
//  Created by Sabih Ahmed on 06/05/2026.
//

import SwiftUI

struct LotCardView: View {
    var lotNumber: Int = 2
    var title: String = "Waves Premium - Villa"
    var estimate: String = "฿ 3.5M"
    var status: String = "Active"
    var belowEstimate: String = "45% below estimate"
    var imageName: String = "villa1"
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image("villa1", bundle: .module)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(8)
                .clipped()
            
            VStack(alignment: .leading, spacing: 6) {
                Text("LOT \(lotNumber): \(title)")
                    .font(.system(size: 14, weight: .bold))
                
                Text("Propify Estimate: \(estimate)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                HStack(spacing: 8) {
                    Text(status)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.green)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .stroke(Color.green, lineWidth: 1)
                        )
                    
                    Text(belowEstimate)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.green)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .stroke(Color.green, lineWidth: 1)
                        )
                }
            }
        }
        .padding()
        .padding(.trailing, 50) // extra space for the info icon
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        
        .overlay(alignment: .trailing) {
            Image(systemName: "info.circle")
                .foregroundColor(.gray)
                .padding(.trailing, 16)
        }
    }}

#Preview {
    LotCardView()
        .padding()
        .background(Color.gray.opacity(0.1))
}
