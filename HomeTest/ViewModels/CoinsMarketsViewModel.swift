//
//  CoinMarketViewModel.swift
//  HomeTest
//
//  Created by Steven on 8/9/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

class CoinsMarketsViewModel {
    private let _coins = BehaviorRelay<[Coin]>(value: [])
    private let disposeBag = DisposeBag()
    
    func getCoinsMarkets(pageSize: Int, page: Int, completion: (() -> Void)? = nil) {
        ApiCoins.getCoinsMarkets(pageSize: pageSize, page: page).subscribe(onNext: {[weak self] (result) in
            if let safeSelf = self {
                switch result {
                case let .success(coinsData):
                    safeSelf._coins.accept(page == 1 ? coinsData : safeSelf._coins.value + coinsData)
                    safeSelf.addToRealm(coins: coinsData)
                    break
                case let .failure(errorMessage):
                    AppHelper.displayError(title: "Error", message: errorMessage)
                    break
                }
            }
        }, onCompleted: {
            completion?()
        }).disposed(by: self.disposeBag)
    }
    
    private func addToRealm(coins: [Coin]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(coins, update: .modified)
        }
    }
    
    var coins: Driver<[Coin]> {
        return self._coins.asDriver(onErrorJustReturn: [])
    }
    
    var coinsSize: Int {
        return self._coins.value.count
    }
}
