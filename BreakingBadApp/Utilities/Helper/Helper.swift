//
//  Helper.swift
//
//  Created by Mahmoud Ismail on 6/15/21.
//

import UIKit
import CoreLocation
class Helper{
    class func createLabel(text:String = "", font:UIFont = DesignSystem.Typography.subHeadline.font, textColor:UIColor = DesignSystem.Colors.blackText.color,textAlignent:NSTextAlignment = .natural) -> UILabel {
        let customLabel = UILabel()
        customLabel.text = text
        customLabel.textColor = textColor
        customLabel.font = font
        customLabel.adjustsFontSizeToFitWidth = true
        customLabel.textAlignment = textAlignent
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        return customLabel
    }

}
