//
//  MainNavigator.swift


import UIKit
import RxCocoa
import RxSwift

class MainNavigator: Navigator{
    
    var coordinator: Coordinator
    
    enum Destination {
     
        //Splash
        case splashScreen
        
        // Home
        case home
        
        //CharacterDetails
        case characterDetails(characters:Observable<[Character]>, selectedIndex:Int)
        
        
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination {
       
        case .splashScreen:
            let viewController = SplashScreenVC()
            let viewModel = SplashScreenViewModel()
            viewController.configure(viewModel: viewModel, coordinator: self.coordinator)
            return viewController
            
        case .home:
            let viewController = HomeVC()
            viewController.modalPresentationStyle = .fullScreen
            let viewModel = HomeViewModel()
            viewController.configure(viewModel: viewModel, coordinator: self.coordinator)
            return viewController
            
        case let .characterDetails(characters, selectedIndex):
            let viewController = CharacterDetailsVC()
            let viewModel = CharacterDetailsViewModel(characters: characters, selectedIndex: selectedIndex)
            viewController.configure(viewModel: viewModel, coordinator: self.coordinator)
            return viewController
      
        }
    }
    
}
