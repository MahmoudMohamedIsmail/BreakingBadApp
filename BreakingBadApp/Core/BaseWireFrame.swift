//
//  BaseWireFrame.swift


import Foundation
import UIKit
import RxSwift
import RxCocoa

class BaseWireFrame<T: BaseViewModel>: UIViewController{
    
    var viewModel: T!
    var coordinator: Coordinator!
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(viewModel: self.viewModel)
        self.view.localizeSubViews()
        baseBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.localization()
        
        //loclize swipe direction for navigation controller
        if let navigationController = self.navigationController{
            navigationController.view.semanticContentAttribute = navigationController.navigationBar.semanticContentAttribute
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
      
    }
    
   
    func bind(viewModel: T){
        fatalError("Override bind function first")
    }
    
    func configure(viewModel: T, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    func baseBind(){
        viewModel.showMessageObservable.subscribe {[weak self] (title, message) in
            guard let self = self else {return}
            AlertManager.showMessage(vc: self,title: title, message: message, observable: nil)
        }.disposed(by: self.disposeBag)
        
    }
    
    func localization(){
        self.view.localizeSubViews()
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
}

