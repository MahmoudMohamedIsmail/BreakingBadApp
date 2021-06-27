//
//  AppStoryboard.swift

import Foundation
import UIKit

enum AppStoryboard: String{
        
    case none
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line, file: String = #file)->T{
        
        let storyboardID: String = viewControllerClass.storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else{
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController()-> UIViewController?{
        return instance.instantiateInitialViewController()
    }
    
}


extension UIViewController{
    
    class var storyboardID: String{
        return String(describing: self)
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard)->Self{
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
}
