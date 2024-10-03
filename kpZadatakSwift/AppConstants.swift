//
//  AppConstants.swift
//  kpZadatakSwift
//
//  Created by Aleksa Dimitrijevic on 3.10.24..
//

import UIKit

/// Konstante unutar aplikacije
enum AppConstants {
    
    /// URL uvek počinje isto
    static var baseUrl: String {
        return "https://images.kupujemprodajem.com"
    }
    
    /// AppTheme će biti korišćeno za postavljanje boja i slika unutar aplikacije
    enum AppTheme {
        
        static var backgroundImage: UIImage { return UIImage(named: "camera") ?? UIImage() }
        
        static var backgroundColor: UIColor {
            return UIColor(named: "BackgroundColor")!
        }
        
        static var bodyTextColor: UIColor {
            return UIColor(named: "BodyTextColor")!
        }
        
        static var redColor: UIColor {
            return UIColor(named: "RedColor")!
        }
        
        static var titleTextColor: UIColor {
            return UIColor(named: "TitleTextColor")!
        }
        
        static var textColor: UIColor {
            return UIColor.black
        }
        
        static var whiteBackground: UIColor {
            return UIColor.white
        }
    }
    
}
