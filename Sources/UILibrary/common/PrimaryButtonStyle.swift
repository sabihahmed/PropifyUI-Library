//
//  SwiftUIView.swift
//  
//
//  Created by Sabih_Ahmed on 22/04/2026.
//
import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .font(.poppinsSemiBold(size: 16))
            .foregroundColor(.white) // replace later
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 96)
                    .fill(configuration.isPressed ? Color.gray : Color.ColorsButtonPrimary) // replace colors
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

import SwiftUI

public struct PrimaryButton: View {
    
    private let title: String
    private let action: () -> Void
    
    // MARK: - Init
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

import SwiftUI

public struct PrimaryButton_Previews: PreviewProvider {
    public static var previews: some View {
        
        VStack(spacing: 20) {
            
            PrimaryButton(title: "Confirm Bid") {
                print("Confirm tapped")
            }
            
            PrimaryButton(title: "Place Offer") {
                print("Offer tapped")
            }
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

