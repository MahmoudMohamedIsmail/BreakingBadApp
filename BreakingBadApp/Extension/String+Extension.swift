//
//  String+.swift


import UIKit

extension String {
    func makePartOfStringBold(boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes: [NSAttributedString.Key.font: font])
        guard let boldFont = UIFont(name: font.familyName + "-Bold", size: font.pointSize) else {return NSMutableAttributedString(string: self)}
        
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont]
        let range = (self as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
}
