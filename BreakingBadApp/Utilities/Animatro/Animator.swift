//
//  AnimationHelper.swift

import UIKit

class Animator {
    
    class func provideAnimation(view: UIView, animationDuration:TimeInterval = 1.0, deleyTime:TimeInterval = 0, springDamping:CGFloat = 0.5, springVelocity:CGFloat = 10.0){
        
        view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: animationDuration,
                       delay: deleyTime,
                       usingSpringWithDamping: springDamping,
                       initialSpringVelocity: springVelocity,
                       options: .allowUserInteraction,
                       animations: {
                        view.transform = CGAffineTransform.identity
        })
    }
    
    class func animateBackgroundView(_ view:UIView){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8) {
                view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            }
        }
    }
    
    class func animateView(_ view:UIView , with alpha:CGFloat){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1) {
                view.alpha = alpha
            }
        }
    }
    
}
