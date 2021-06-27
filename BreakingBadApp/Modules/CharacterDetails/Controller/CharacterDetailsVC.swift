//
//  CharacterDetailsVC.swift
//  BreakingBadApp
//
//  Created by Mahmoud Ismail on 6/27/21.
//

import UIKit

class CharacterDetailsVC: BaseWireFrame<CharacterDetailsViewModel> {

    @IBOutlet weak var back_Btn: UIButton!
    @IBOutlet weak var character_CollectionView: UICollectionView!{
        didSet{
            character_CollectionView.registerCellNib(cellClass: CharacterDetailsCell.self)
        }
    }
    
    @IBOutlet weak var previous_Btn: DesignableUIButton!{
        didSet{
            previous_Btn.addBlurEffect(alpha: 0.5)
        }
    }
    @IBOutlet weak var next_Btn: DesignableUIButton!{
        didSet{
            next_Btn.addBlurEffect(alpha: 0.5)
        }
    }
    @IBOutlet weak var pageControl_PG: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    override func bind(viewModel: CharacterDetailsViewModel) {
        handleCharacterDetails_CollectionView()
        handleBackButton()
        handleNextAndPreviousButtons()
        subscribeToAllCharacters()
        handlePageControl()
        subscribeToSelectedIndex()
    }
    
    
    private func handleCharacterDetails_CollectionView(){
        // set delegate to self
        character_CollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // bind viewModel characters data to characterDetails_CollectionView
        viewModel.outputs.charactersObservable.bind(to: character_CollectionView.rx.items(cellIdentifier: CharacterDetailsCell.identifier, cellType: CharacterDetailsCell.self)){ [weak self](row, model, cell) in
            cell.characterModel = model
            self?.character_CollectionView.layoutIfNeeded()
        }.disposed(by: disposeBag)
        
        // will display cell
        character_CollectionView.rx.willDisplayCell.subscribe {[weak self] (cell, indexPath) in
            guard let cell = cell as? CharacterDetailsCell else {return}
            cell.characterImge_ImgView.alpha = 0
            Animator.animateView(cell.characterImge_ImgView, with: 1)
        }.disposed(by: disposeBag)
     
    }
    
    private func subscribeToAllCharacters(){
        self.viewModel.outputs.charactersObservable.subscribe(onNext: {[weak self] (characters) in
            guard let self = self else {return}
            let selectedIndex = self.viewModel.outputs.selectedIndex.value
            self.pageControl_PG.numberOfPages = characters.count
            self.pageControl_PG.currentPage = selectedIndex
            DispatchQueue.main.async {
                self.character_CollectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
            }
        }).disposed(by: disposeBag)
    }
    
    private func handleNextAndPreviousButtons(){
        next_Btn.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.character_CollectionView.scrollToItem(at: IndexPath(row: self.viewModel.outputs.selectedIndex.value + 1, section: 0), at: .centeredHorizontally, animated: false)
            }
        }.disposed(by: disposeBag)
        
        previous_Btn.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.character_CollectionView.scrollToItem(at: IndexPath(row: self.viewModel.outputs.selectedIndex.value - 1, section: 0), at: .centeredHorizontally, animated: false)
            }
        }.disposed(by: disposeBag)
    }
    
    private func handleBackButton(){
        back_Btn.rx.tap.subscribe {[weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)

    }
    private func subscribeToSelectedIndex(){
        self.viewModel.outputs.selectedIndex.subscribe(onNext: { [weak self](index) in
            guard let self = self else {return}
            self.previous_Btn.isHidden = (index == 0) ? true:false
            self.next_Btn.isHidden = (index == self.viewModel.outputs.numberOfCharacters - 1) ? true:false
        }).disposed(by: disposeBag)
    }
    
    private func handlePageControl(){
        self.viewModel.outputs.selectedIndex.bind(to: pageControl_PG.rx.currentPage).disposed(by: disposeBag)
    }
    
}
//MARK:- UICollectionViewDelegateFlowLayout + set size for CharacterImage to character_CollectionView size
extension CharacterDetailsVC:UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = self.view.bounds.size.width
        let currentPage: Int = Int((scrollView.contentOffset.x + (width)) / width) - 1
        self.viewModel.outputs.selectedIndex.accept(currentPage)
    }
    
}
