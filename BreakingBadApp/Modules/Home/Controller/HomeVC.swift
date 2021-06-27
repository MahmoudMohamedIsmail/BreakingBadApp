//
//  HomeVC.swift
//  BreakingBadApp
//
//  Created by Mahmoud Ismail on 6/23/21.
//

import RxCocoa
import RxSwift

class HomeVC: BaseWireFrame<HomeViewModel> {
    
    @IBOutlet weak var logo_ImgView: UIImageView!
    @IBOutlet weak var logoBottomConstraint_NSConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoTopConstraint_NSConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoWidhtConstraint_NSConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightConstraint_NSConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundWallpaper_ImgView: UIImageView!
    
    @IBOutlet weak var banner_CollectionView: UICollectionView!{
        didSet{
            banner_CollectionView.registerCellNib(cellClass: BannerCell.self)
        }
    }
    
    @IBOutlet weak var characterList_TableView: UITableView!{
        didSet{
            characterList_TableView.registerCellNib(cellClass: CharacterCell.self)
            characterList_TableView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
        }
    }
    
    @IBOutlet weak var listOfCharacters_ImgView: UIImageView!
    private var isAnimating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleAnimatin()
    }
    

    override func bind(viewModel: HomeViewModel) {
        handleBanner_CollectionView()
        handleCharacterList_TableView()
    }
    
    private func handleBanner_CollectionView(){
        // set delegate to self#imageLiteral(resourceName: "simulator_screenshot_00A81A2E-A4E5-49D8-9AF4-8B44EA00B29E.png")
        banner_CollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // bind viewModel banners data to banner_CollectionView
        viewModel.outputs.bannersObservable.bind(to: banner_CollectionView.rx.items(cellIdentifier: BannerCell.identifier, cellType: BannerCell.self)){ [weak self](row, model, cell) in
            cell.model = model
        }.disposed(by: disposeBag)
        
        // subscribe to Banners to set initail offset for banner_CollectionView
        viewModel.outputs.bannersObservable.subscribe(onNext: { [weak self](banners) in
            guard let self = self else {return}
            self.centralizeBannerCell(bannerCount: banners.count)
        }).disposed(by: disposeBag)
    }
    
    private func handleCharacterList_TableView(){
        // bind viewModel characters data to charactersList_TableView
        viewModel.outputs.charactersObservable.bind(to: characterList_TableView.rx.items(cellIdentifier: CharacterCell.identifier, cellType: CharacterCell.self)){ [weak self](row, model, cell) in
            cell.characterModel = model
        }.disposed(by: disposeBag)
        
        
        // to handle pagination
        characterList_TableView.rx.prefetchRows.subscribe(onNext: {[weak self] (indexPaths) in
            self?.viewModel.inputs.prefetchRowsAt(indexPaths: indexPaths)
        }).disposed(by: disposeBag)
        
        
        //set didselected cell
        characterList_TableView.rx.itemSelected.subscribe(onNext: {[weak self] (indexPath) in
            guard let self = self else {return}
            self.coordinator.mainNavigator.navigate(to: .characterDetails(characters: self.viewModel.charactersObservable, selectedIndex: indexPath.row))
        }).disposed(by: disposeBag)
        
    }
    
    
    
    
    private func centralizeBannerCell(bannerCount:Int){
        let totalCellWidht =  self.banner_CollectionView.frame.width - 60
        let totalSpacingWidth = 10 * (bannerCount - 1)
        
        let totalBannerContentWidth = (Int(totalCellWidht) * bannerCount) + totalSpacingWidth
        
        self.banner_CollectionView.contentOffset.x = CGFloat(totalBannerContentWidth / 2) - (self.banner_CollectionView.frame.width / 2)
    }
    
}
//MARK:- UICollectionViewDelegateFlowLayout + set size for BannerCell to Banner_CollectionView size
extension HomeVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: collectionView.frame.height)
    }
    
}

//MARK:- Handle Animation
extension HomeVC{
    private func handleAnimatin(){
        guard  !isAnimating else {return}
        self.isAnimating = true
        let heightWithoutSafeArea = view.safeAreaLayoutGuide.layoutFrame.size.height
        self.logoTopConstraint_NSConstraint.constant = heightWithoutSafeArea - 185
        DispatchQueue.main.async {
            self.logoTopConstraint_NSConstraint.constant = 25
            self.logoWidhtConstraint_NSConstraint.constant = 138
            self.logoHeightConstraint_NSConstraint.constant = 82
            UIView.animate(withDuration: 1.5) {
                self.view.layoutIfNeeded()
            } completion: { [weak self](_) in
                guard let self = self else {return}
                
                UIView.animate(withDuration: 0.5) {
                    self.listOfCharacters_ImgView.isHidden = true
                    self.backgroundWallpaper_ImgView.layer.compositingFilter = "multiplyBlendMode"
                    self.backgroundWallpaper_ImgView.alpha = 0.5
                    self.view.layoutIfNeeded()
                }
                
            }
        }
    }
}
