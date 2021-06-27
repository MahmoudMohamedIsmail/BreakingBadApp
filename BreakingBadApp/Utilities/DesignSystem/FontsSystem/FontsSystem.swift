//
//  FontsSystem.swift



import Foundation
import UIKit

struct CustomFontDescriptor{
    var font: Fonts
    var size: CGFloat
    var style: UIFont.TextStyle
}

extension DesignSystem {
    enum Typography{
        case headline
        case mediumHeadline
        case subHeadline
        case footnote
        case body
        case callout
        case defaultButton
        case bigButton
        case footer
        case buttonSmall
        case paragraph
        
        private var descriptor: CustomFontDescriptor {
            switch self {
            case .headline:
                return  CustomFontDescriptor(font: .bold, size: 24, style: .headline)
            case .mediumHeadline:
                return  CustomFontDescriptor(font: .semibold, size: 16, style: .subheadline)
            case .subHeadline:
                return  CustomFontDescriptor(font: .medium, size: 14, style: .subheadline)
            case .footnote:
                return  CustomFontDescriptor(font: .regular, size: 12, style: .footnote)
            case .body:
                return  CustomFontDescriptor(font: .regular, size: 17, style: .body)
            case .callout:
                return  CustomFontDescriptor(font: .regular, size: 16, style: .callout)
            case .bigButton:
                return CustomFontDescriptor(font: .medium, size: 18, style: .headline)
            case .defaultButton:
                return CustomFontDescriptor(font: .semibold, size: 14, style: .subheadline)
            case .footer:
                return CustomFontDescriptor(font: .semibold, size: 12, style: .footnote)
            default:
                return CustomFontDescriptor(font: .regular, size: 18, style: .body)
            }
        }
        
        var font: UIFont {
            guard let font = UIFont(name: descriptor.font.name, size: descriptor.size) else{
                return UIFont.preferredFont(forTextStyle: descriptor.style)
            }
            let fontMetrics = UIFontMetrics(forTextStyle: descriptor.style)
            return fontMetrics.scaledFont(for: font)
        }
    }
}
