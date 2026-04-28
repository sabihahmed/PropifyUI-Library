//
//  SwiftUIView.swift
//  
//
//  Created by Sabih_Ahmed on 28/04/2026.
//

import SwiftUI

public struct TextualChip: View {
    
    public enum ColoredState : String {
        case red
        case green
    }
    
    let text : String
    let state : ColoredState
    
    public init(text: String, state: ColoredState){
        self.text = text
        self.state = state
    }
    
    public var body: some View {
        
        Text(text)
            .font(.poppinsSemiBold(size: 12))
            .padding(.horizontal, 10)
            .padding(.vertical, 2)
            .frame(height: 20)
            .background(getBackgroundColor(state))
            .foregroundColor(getForegroundColor(state)) // placeholder
            .cornerRadius(16)
    }
    
    func getForegroundColor(_ state : ColoredState) -> Color {
        
        switch state {
            case .red:
                return Color.ColorsTextWarning
            
            case .green:
                return Color.ColorsAlertsTextOnSuccess

        }
    }
    
    func getBackgroundColor (_ state: ColoredState) -> Color {
        
        switch state {
        case.red:
            return Color.ColorsAlertsBackgroundErrorSubtle
        case.green:
            return Color.ColorsAlertsBackgroundSuccess
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextualChip(text: "45% below average", state: .green)
            TextualChip(text: "10% Above market", state: .red)
        }
        
    }
}
