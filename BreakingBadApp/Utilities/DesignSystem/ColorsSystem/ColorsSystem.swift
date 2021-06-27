//
//  Colors.swift

import Foundation
import UIKit


extension DesignSystem {
    enum Colors: String {
        case primary = "Primary"
        case primarySelected = "PrimarySelected"
        case primaryBackground = "PrimaryBackground"
        case darkPrimary = "DarkPrimary"
        case primaryElementBackground = "PrimaryElementBackground"
        case primaryTransparentBackground = "PrimaryTransparentBackground"
        case primaryGray = "PrimaryGray"
        case shadow = "Shadow"
        case border = "BorderColor"
        case blackText = "BlackText"
        case primaryRed = "PrimaryRed"
        case primaryYellow = "PrimaryYellow"
        case lightPrimary = "LightPrimary"
        case meduimGray = "MeduimGray"
        
        case placeHolderPrimary = "PlaceholderPrimary"
        
        var color: UIColor{
            return UIColor(named: self.rawValue)!
        }
    }
}
