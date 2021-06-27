//
//  SplashScreenVC.swift
//  BreakingBadApp
//
//  Created by Mahmoud Ismail on 6/23/21.
//

import UIKit

class SplashScreenVC: BaseWireFrame<SplashScreenViewModel> {
    
    @IBOutlet weak var bottomLogo_NSConstraint: NSLayoutConstraint!
    
    private lazy var timer:Timer? = nil{
        willSet{
            timer?.invalidate()
        }
    }
    private var isAnimating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTimer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.layoutIfNeeded()
        self.navigateToHome()
    }
    
    override func bind(viewModel: SplashScreenViewModel) {
        
    }
    
    
    private func configureTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { [weak self](_) in
            guard let self = self else {return}
            self.navigateToHome()
        })
    }
    
    private func navigateToHome(){
        timer?.invalidate()
        self.timer = nil
        self.coordinator.mainNavigator.navigate(to: .home, with: .push(animated: false))
    }
}
//MARK:- Handle Animation

extension SplashScreenVC{
    private func handleAnimatin(){
        guard  !isAnimating else {return}
        self.isAnimating = true
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1) {
                self.bottomLogo_NSConstraint.constant = (self.view.frame.height/2) - 60
                self.view.layoutIfNeeded()
            } completion: { [weak self](_) in
                guard let self = self else {return}
                self.navigateToHome()
            }
        }
    }
}
