//
//  HomeViewModel.swift
//  BreakingBadApp
//
//  Created by Mahmoud Ismail on 6/23/21.
//

import RxSwift
import RxRelay

protocol HomeViewModelInput {
    func prefetchRowsAt(indexPaths: [IndexPath])
}
protocol HomeViewModelOutput {
    var bannersObservable:Observable<[String]>{get}
    var numberOfBanners:Int{get}
    var charactersObservable:Observable<[Character]>{get}
}

class HomeViewModel:BaseViewModel, HomeViewModelInput, HomeViewModelOutput {
    
    var inputs:HomeViewModelInput{return self}
    var outputs:HomeViewModelOutput{return self}
    
    //outputs
    private var banners:BehaviorRelay<[String]> = .init(value: [])
    var bannersObservable: Observable<[String]> {
        return banners.asObservable()
    }
    var numberOfBanners:Int{
        return banners.value.count
    }
    
    private var characters:BehaviorRelay<[Character]> = .init(value: [])
    var charactersObservable: Observable<[Character]> {
        return characters.asObservable()
    }
    
    private var pagination:Pagination!
    
     init() {
        super.init()
        pagination = Pagination()
        banners.accept(["Banner1_IMG", "Banner2_IMG", "Banner3_IMG"])
        getCharacters()

    }
    
    func prefetchRowsAt(indexPaths: [IndexPath]) {
        guard let indexPath = indexPaths.last else {return}
        if (indexPath.row  > (self.characters.value.count - 5)){
            guard !pagination.noMorePages else {
                getNextPageWhenNoMoreData() // to handel infinite scrolling
                return
            }
            guard !pagination.isFeatching else {return}
            pagination.pageNumber += 1
            getCharacters()
        }
    }
    
    // to make infinite scrolling
    private func getNextPageWhenNoMoreData(){
        let startIndex = (pagination.pageNumber * pagination.numberOfItemPerPage) % characters.value.count
        let endIndex = startIndex + pagination.numberOfItemPerPage
        if  endIndex < characters.value.count {
            let nextCharactersList = characters.value[startIndex..<endIndex]
            self.characters.accept(characters.value + nextCharactersList)
        }
        else {
            let nextCharactersList = characters.value[startIndex..<characters.value.count]
            self.characters.accept(characters.value + nextCharactersList)
        }
    
    }
    
}

extension HomeViewModel{
    private func getCharacters(){
        pagination.isFeatching = true
        appServiceClint.performRequest([Character].self, serviceGateway: .getCharacters(limit: self.pagination.numberOfItemPerPage, offset: self.characters.value.count)).subscribe {[weak self] (characters) in
            guard let self = self else {return}
            self.pagination.isFeatching = false
            
            if characters.isEmpty {
                self.pagination.noMorePages = true
                self.pagination.pageNumber = 0 //
                self.getNextPageWhenNoMoreData()
                return
            }
            
            if self.pagination.pageNumber == 0 {
                self.characters.accept(characters)
            }
            else {
                self.characters.accept(self.characters.value + characters)
            }
            
        } onError: { [weak self](error) in
            print(error.localizedDescription)
        }.disposed(by: disposeBag)

    }
}
