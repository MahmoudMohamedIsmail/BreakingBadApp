//
//  AppCoordinator.swift


import Foundation
import UIKit

protocol Coordinator {
    func start()
    var tabBar: UITabBarController {get}
    var navigationController: UINavigationController! { get }
    var tabBarSelectedItemNavigation: UINavigationController? { get set}
    var mainNavigator: MainNavigator { get }
    var topViewController: UIViewController {get}
}

class AppCoordinator: Coordinator{
    
    var navigationController: UINavigationController!
    var window: UIWindow
    
    lazy var mainNavigator: MainNavigator = {
        return .init(coordinator: self)
    }()
    
    init(window: UIWindow = UIWindow()) {
        self.window = window
        self.window.backgroundColor = .white
    }
    
    var tabBarSelectedItemNavigation: UINavigationController?
    
    var tabBar: UITabBarController{
        get{
            return UITabBarController()
        }
    }
    
    var topViewController: UIViewController{
        return self.getTopViewController(self.rootViewController) ?? self.rootViewController
    }
    
    private func getTopViewController(_ viewController: UIViewController?) -> UIViewController? {
        if let navController = viewController as? UINavigationController {
            return getTopViewController(navController.visibleViewController)
        } else if let tab = viewController as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(selected)
            
        } else if let presented = viewController?.presentedViewController {
            return getTopViewController(presented)
        }
        return viewController
    }
    
    var rootViewController: UIViewController{
        let viewController = mainNavigator.viewController(for: .splashScreen)
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
        return navigationController
    }
    
    
    func start(){
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
}
