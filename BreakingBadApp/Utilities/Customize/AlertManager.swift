//
//  AlertManager.swift
//
//  Created by Mahmoud Ismail on 6/14/21.
//

import UIKit
import RxSwift
final class AlertManager {
    
    typealias ActionBtnBehavior = (title:String, observable:PublishSubject<Void>?, color:UIColor?)
    typealias TextBehavior = (text:String?, color:UIColor?)
    
    static func showAlertMessage(vc:UIViewController, coordinator:Coordinator,title:TextBehavior, message:TextBehavior, actions:ActionBtnBehavior...){
        
        let messageAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        messageAlert.set(title: title.text ?? "Ops!", font: .mediumHeadline, color: title.color)
        messageAlert.set(message: message.text ?? "", font: .footnote, color: message.color)
        
        actions.forEach { (actionBehavior) in
            if actionBehavior.observable == nil {
                messageAlert.addAction(name: actionBehavior.title, style: .cancel, action: nil, color: actionBehavior.color)
                
            }
            else {
            messageAlert.addAction(name: actionBehavior.title, style: .default, action: { (_) in
                actionBehavior.observable?.onNext(())
            }, color: actionBehavior.color)
                
            }
        }
        vc.present(messageAlert, animated: true, completion: nil)
    }
    
    static func showMessage(vc:UIViewController, title: String?, message: String, observable: PublishSubject<Void>?){
        let messageAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        messageAlert.set(title: title ?? "Ops!", font: .mediumHeadline, color: DesignSystem.Colors.primary.color)
        messageAlert.set(message: message, font: .footnote, color: DesignSystem.Colors.meduimGray.color)
        messageAlert.addAction(name: "Ok", style: .cancel, action: {(_) in
            observable?.onNext(())
        }, color: DesignSystem.Colors.primary.color)
        vc.present(messageAlert, animated: true, completion: nil)
    }
}

