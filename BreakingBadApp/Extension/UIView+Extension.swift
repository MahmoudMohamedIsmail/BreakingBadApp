//
//  UIView+Extension.swift

import UIKit

extension UIView{
    
    //Variadic
    func addSubviews(_ views: UIView...) {
        views.forEach({self.addSubview($0)})
    }
    
    func insertSubViews(_ views: UIView...) {
        views.forEach({self.insertSubview($0, at: 0)})
    }
    
    func addShimmerLayer(){
        layer.cornerRadius = frame.height * 0.15
        layer.masksToBounds = true
        //        backgroundColor = UIColor.hexStringToUIColor(hex: "#D8D8D8")
        UIView.animate(withDuration: 0.55, delay: 0, options: [.autoreverse, .curveLinear, .repeat], animations: {
            self.alpha = 0.6
        }) { (_) in
            self.alpha = 1
        }
    }
    
    func localizeSubViews() {
        self.subviews.forEach { (view) in
            if let lbl = view as? UILabel {
                lbl.localize()
            } else if let btn = view as? UIButton {
                btn.localize()
            } else if let tf = view as? UITextField {
                tf.localize()
            }else if let textView = view as? UITextView {
                textView.localize()
            } else {
                view.localizeSubViews()
            }
        }
    }
    
    func addBlurEffect(alpha:CGFloat = 0.8){
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.isUserInteractionEnabled = false
        blurEffectView.alpha = alpha
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.insertSubview(blurEffectView, at: 0)
    }
}
