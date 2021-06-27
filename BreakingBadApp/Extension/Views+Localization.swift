//
//  Views+Localization.swift


import UIKit

extension UITextField {
    
    func localize() {
        
            self.text = self.text ?? ""
            self.text = self.text!
        
        if self.textAlignment == .left || self.textAlignment == .right {
            if LanguageManager.sharedInstance.isRTL()  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
}

extension UILabel{
    
    func localize(){
        
        self.text = self.text ?? ""
        
        if self.textAlignment == .left || self.textAlignment == .right {
            if LanguageManager.sharedInstance.isRTL()  {
                self.textAlignment = .right
            } else{
                self.textAlignment = .left
            }
        }
    }
}

extension UIButton {
    
    func localize() {
        let localizedString = self.titleLabel?.text ?? ""
        self.setTitle(localizedString, for: .normal)
        
        if self.contentHorizontalAlignment == .right || self.contentHorizontalAlignment == .left {
            if LanguageManager.sharedInstance.isRTL()  {
                self.contentHorizontalAlignment = .right
            } else {
                self.contentHorizontalAlignment = .left
            }
        }
        
    }
}

extension UITextView {
    
    func localize() {
        
        self.text = self.text ?? ""

        if self.textAlignment == .left || self.textAlignment == .right {
            if LanguageManager.sharedInstance.isRTL()  {
                self.textAlignment = .right
            } else{
                self.textAlignment = .left
            }
        }
        
    }
}

