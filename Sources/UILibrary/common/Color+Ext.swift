//
//  SwiftUIView.swift
//
//
//  Created by Sabih Ahmed on 06/06/2024.
//

import SwiftUI
import UIKit

public extension Color {
    
    static let ColorsTextSecondary: Color = Color(red: 0.36, green: 0.46, blue: 0.5)
    static let ColorsTextPrimary: Color = Color(red: 0.06, green: 0.06, blue: 0.06)

     struct Text {
        public static let Primary: Color = Color(red: 0.06, green: 0.06, blue: 0.06)
        public static let Secondary: Color = Color(red: 0.36, green: 0.46, blue: 0.5)
    }
     
    
    
     struct Tertiary{
        public static let _900 = Color(red: 0.65, green: 0.81, blue: 0 )
        
    }
    
    
     struct HueGray{
        public static let _900 = Color(red: 0.65, green: 0.65, blue: 0.62)
        
    }
    
     struct Gray{
        public static let _900 = Color(red: 0.17, green: 0.2, blue: 0.18)
        
    }
    
     struct Alert{
        public static let _negative    = Color(red: 0.65, green: 0, blue: 0)
        
    }
    
     struct AlertLight{
        public static let _negative    = Color(red: 0.96, green: 0.83, blue: 0.83)
        
        
    }
    
     struct Skrimming{
        public static let _skrim = Color(red: 0.18, green: 0.21, blue: 0.24).opacity(0.3)
    }
    
     struct Neutral{
        public static let _black = Color.black
        public static let _white = Color.white
        
    }
    
}


public extension Color {
 
    func uiColor() -> UIColor {

        if #available(iOS 14.0, *) {
            return UIColor(self)
        }

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}
