//
//  CharacterDetailsViewModel.swift
//  BreakingBadApp
//
//  Created by Mahmoud Ismail on 6/27/21.
//


import RxSwift
import RxRelay

protocol CharacterDetailsViewModelInput {
    
}
protocol CharacterDetailsViewModelOutput {
    var charactersObservable:Observable<[Character]>{get}
    var selectedIndex:BehaviorRelay<Int>{get set}
    var numberOfCharacters:Int{get}
}

class CharacterDetailsViewModel: BaseViewModel, CharacterDetailsViewModelInput, CharacterDetailsViewModelOutput {
    
    var inputs:CharacterDetailsViewModelInput{return self}
    var outputs:CharacterDetailsViewModelOutput{return self}
    
    private var characters:BehaviorRelay<[Character]> = .init(value: [])
    var charactersObservable: Observable<[Character]> {
        return characters.asObservable()
    }
    
    var selectedIndex:BehaviorRelay<Int> = .init(value: 0)
    var numberOfCharacters:Int{
        return characters.value.count
    }
    
    init(characters:Observable<[Character]>, selectedIndex:Int) {
        super.init()
        self.selectedIndex.accept(selectedIndex)
        characters.bind(to: self.characters).disposed(by: disposeBag)
    }
    
    
}
