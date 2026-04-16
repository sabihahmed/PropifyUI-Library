//
//  File.swift
//  
//
//  Created by Sabih Ahmed on 07/06/2024.
//

import SwiftUI
import UIKit

public extension Font {
    
    
    
    // MARK: - Poppins
    
    static func poppinsRegular(size: CGFloat) -> Font? {
        return Font.custom("Poppins-Regular", size: size)
    }
    
    static func poppinsMedium(size: CGFloat) -> Font? {
        return Font.custom("Poppins-Medium", size: size)
    }
    
    static func poppinsBold(size: CGFloat) -> Font? {
        return Font.custom("Poppins-Bold", size: size)
    }
    static func poppinsSemiBold(size: CGFloat) -> Font? {
        return Font.custom("Poppins-SemiBold", size: size)
    }
    static func poppinsItalic(size: CGFloat) -> Font? {
        return Font.custom("Poppins-Italic", size: size)
    }


    static func regular(_ size: CGFloat = 12) -> Font? {
        return Font.custom("NeueFrutigerArabic-Regular", size: size)
        
//        if LocalizationSystem.sharedInstance.getLanguage() == .AR {
//            return Font.custom("NeueFrutigerArabic-Regular", size: size)
//        } else {
//            return Font.custom("Archivo-Regular", size: size)
//        }

    }
    
    static func medium(_ size: CGFloat) -> Font? {
        return Font.custom("NeueFrutigerArabic-Medium", size: size)
//        if LocalizationSystem.sharedInstance.getLanguage() == .AR {
//
//        } else {
//            return Font.custom("Archivo-Medium", size: size)
//        }

    }
    
    //Semibold will not be used as per UX Team
    static func semiBold(_ size: CGFloat = 12) -> Font? {
        return Font.custom("NeueFrutigerArabic-Medium", size: size)
//        if LocalizationSystem.sharedInstance.getLanguage() == .AR {
//
//        } else {
//            return Font.custom("Archivo-Medium", size: size)
//        }
 
    }

    static func bold(_ size: CGFloat = 12) -> Font? {
        return Font.custom("NeueFrutigerArabic-Bold", size: size)
//        if LocalizationSystem.sharedInstance.getLanguage() == .AR {
//
//        }else {
//            return Font.custom("Archivo-Bold", size: size)
//        }
    }
    
    //ARABIC FONT HELPERS
    
    static func regularArabic(_ size: CGFloat = 12) -> Font? {

        return Font.custom("NeueFrutigerArabic-Regular", size: size)

    }
    
    static func mediumArabic(_ size: CGFloat) -> Font? {
        return Font.custom("NeueFrutigerArabic-Medium", size: size)

    }
    
    //Semibold will not be used as per UX Team
    static func semiBoldArabic(_ size: CGFloat = 12) -> Font? {
        return Font.custom("NeueFrutigerArabic-Medium", size: size)
 
    }

    static func boldArabic(_ size: CGFloat = 12) -> Font? {
        return Font.custom("NeueFrutigerArabic-Bold", size: size)
    }
    
    static func mediumEnglish(_ size: CGFloat) -> Font? {
        return Font.custom("Archivo-Medium", size: size)

    }
}

//extension UIFont {
//    static func mediumUIFont(_ size: CGFloat) -> UIFont {
//        return UIFont(name: "NeueFrutigerArabic-Medium", size: size)
//
////        if LocalizationSystem.sharedInstance.getLanguage() == .AR {
////            ?? UIFont.systemFont(ofSize: size)
////        } else {
////            return UIFont(name: "Archivo-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
////
////        }
//    }
//}
