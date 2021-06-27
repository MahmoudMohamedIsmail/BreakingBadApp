//
//  DesignableUITextField.swift
//
//  Created by Mahmoud Ismail on 03/03/2021.
//

import UIKit

@IBDesignable
class DeisgnableUITextField: UITextField{

    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable
    var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat = 0.0 {
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable
    var shadowOpacity: Float = 0.0 {
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable
    var shadowOffset: CGSize = CGSize.zero{
        didSet{
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    //padding to text
    var padding : UIEdgeInsets  {
        
        let paaddingForClearButton = (clearButtonMode == .whileEditing || clearButtonMode == .always ) ? CGFloat(20):0
        var leftPadding = (leftView?.frame.width ?? 0) + 10
        var rightPadding = (rightView?.frame.width ?? 0) + 10 + paaddingForClearButton
        if self.semanticContentAttribute == .forceRightToLeft
        {
             leftPadding = (rightView?.frame.width ?? 0) + 10 + paaddingForClearButton
             rightPadding = (leftView?.frame.width ?? 0) + 10
        }
        return   UIEdgeInsets(top: 0, left:  leftPadding, bottom: 0, right: rightPadding)
    }
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }



}

