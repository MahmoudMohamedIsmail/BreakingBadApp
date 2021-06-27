//
//  Fonts.swift

import Foundation

enum Fonts: String{
    case light = "Montserrat-Light"
    case regular = "Montserrat-Regular"
    case medium = "Montserrat-Medium"
    case semibold = "Montserrat-SemiBold"
    case bold = "Montserrat-Bold"
    case Black = "Montserrat-Black"

    var name: String{
        return self.rawValue
    }
}
