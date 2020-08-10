//
//  CoinViewModel.swift
//  HomeTest
//
//  Created by Steven on 8/9/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct DetailsHeader: Equatable {
    var title: String
    var value: String
}

class CoinViewModel {
    private let _detailsHeaders = BehaviorRelay<[DetailsHeader]>(value: [])
    
    private let _id = BehaviorRelay<String>(value: "")
    private let _symbol = BehaviorRelay<String>(value: "")
    private let _name = BehaviorRelay<String>(value: "")
    private let _image = BehaviorRelay<String>(value: "")
    private let _currentPrice = BehaviorRelay<Float>(value: 0)
    private let _marketCap = BehaviorRelay<OptionalFloat>(value: OptionalFloat())
    private let _marketCapRank = BehaviorRelay<Int>(value: 0)
    private let _totalVolume = BehaviorRelay<Float>(value: 0)
    private let _high24H = BehaviorRelay<OptionalFloat>(value: OptionalFloat())
    private let _low24H = BehaviorRelay<OptionalFloat>(value: OptionalFloat())
    private let _priceChange24H = BehaviorRelay<OptionalFloat>(value: OptionalFloat())
    private let _priceChangePercentage24H = BehaviorRelay<OptionalFloat>(value: OptionalFloat())
    private let _marketCapChange24H = BehaviorRelay<OptionalFloat>(value: OptionalFloat())
    private let _marketCapChangePercentage24H = BehaviorRelay<OptionalFloat>(value: OptionalFloat())
    private let _circulatingSupply = BehaviorRelay<OptionalFloat>(value: OptionalFloat())
    private let _totalSupply = BehaviorRelay<OptionalFloat>(value: OptionalFloat())
    
    init(coin: Coin) {
        self._id.accept(coin.id)
        self._symbol.accept(coin.symbol)
        self._name.accept(coin.name)
        self._image.accept(coin.image)
        self._currentPrice.accept(coin.currentPrice)
        self._marketCap.accept(coin.marketCap ?? OptionalFloat())
        self._marketCapRank.accept(coin.marketCapRank)
        self._totalVolume.accept(coin.totalVolume)
        self._high24H.accept(coin.high24H ?? OptionalFloat())
        self._low24H.accept(coin.low24H ?? OptionalFloat())
        self._priceChange24H.accept(coin.priceChange24H ?? OptionalFloat())
        self._priceChangePercentage24H.accept(coin.priceChangePercentage24H ?? OptionalFloat())
        self._marketCapChange24H.accept(coin.marketCapChange24H ?? OptionalFloat())
        self._marketCapChangePercentage24H.accept(coin.marketCapChangePercentage24H ?? OptionalFloat())
        self._circulatingSupply.accept(coin.circulatingSupply ?? OptionalFloat())
        self._totalSupply.accept(coin.totalSupply ?? OptionalFloat())
        
        var headersData: [DetailsHeader] = []
        headersData.append(DetailsHeader(title: "Name", value: coin.name))
        headersData.append(DetailsHeader(title: "Symbol", value: coin.symbol))
        headersData.append(DetailsHeader(title: "Current Price", value: String(format: "%.0f", coin.currentPrice)))
        headersData.append(DetailsHeader(title: "Market Cap", value: String(format: "%.0f", coin.marketCap?.zeroOrValue ?? 0)))
        headersData.append(DetailsHeader(title: "Market Capp Rank", value: "\(coin.marketCapRank)"))
        headersData.append(DetailsHeader(title: "Total Volume", value: String(format: "%.0f", coin.totalVolume)))
        headersData.append(DetailsHeader(title: "High 24h", value: String(format: "%.0f", coin.high24H?.zeroOrValue ?? 0)))
        headersData.append(DetailsHeader(title: "Low 24h", value: String(format: "%.0f", coin.low24H?.zeroOrValue ?? 0)))
        headersData.append(DetailsHeader(title: "Price Change 24h", value: String(format: "%.0f", coin.priceChange24H?.zeroOrValue ?? 0)))
        headersData.append(DetailsHeader(title: "Price Change Percentage 24h", value: String(format: "%.0f", (coin.priceChangePercentage24H?.zeroOrValue ?? 0) * 100) + "%"))
        headersData.append(DetailsHeader(title: "Market Cap Change 24h", value: String(format: "%.0f", coin.marketCapChange24H?.zeroOrValue ?? 0)))
        headersData.append(DetailsHeader(title: "Market Cap Change Percentage 24h", value: String(format: "%.0f", (coin.marketCapChangePercentage24H?.zeroOrValue ?? 0) * 100) + "%"))
        headersData.append(DetailsHeader(title: "Circulating Supply", value: String(format: "%.0f", coin.circulatingSupply?.zeroOrValue ?? 0)) )
        headersData.append(DetailsHeader(title: "Total Supply", value: String(format: "%.0f", coin.totalSupply?.zeroOrValue ?? 0)))
        self._detailsHeaders.accept(headersData)
    }
    
    var headersAndValues: Driver<[DetailsHeader]> {
        return self._detailsHeaders.asDriver()
    }
    
    var id: Driver<String> {
        return self._id.asDriver()
    }

    var symbol: Driver<String> {
        return self._symbol.asDriver()
    }

    var name: Driver<String> {
        return self._name.asDriver()
    }

    var image: Driver<String> {
        return self._image.asDriver()
    }

    var currentPrice: Driver<Float> {
        return self._currentPrice.asDriver()
    }

    var marketCap: Driver<Float> {
        return self._marketCap.asDriver().map { (data) -> Float in
            return data.zeroOrValue
        }
    }

    var marketCapRank: Driver<Int> {
        return self._marketCapRank.asDriver()
    }

    var totalVolume: Driver<Float> {
        return self._totalVolume.asDriver()
    }

    var high24H: Driver<Float> {
        return self._high24H.asDriver().map { (data) -> Float in
            return data.zeroOrValue
        }
    }

    var low24H: Driver<Float> {
        return self._low24H.asDriver().map { (data) -> Float in
            return data.zeroOrValue
        }
    }

    var priceChange24H: Driver<Float> {
        return self._priceChange24H.asDriver().map { (data) -> Float in
            return data.zeroOrValue
        }
    }

    var priceChangePercentage24H: Driver<Float> {
        return self._priceChangePercentage24H.asDriver().map { (data) -> Float in
            return data.zeroOrValue
        }
    }

    var marketCapChange24H: Driver<Float> {
        return self._marketCapChange24H.asDriver().map { (data) -> Float in
            return data.zeroOrValue
        }
    }

    var marketCapChangePercentage24H: Driver<Float> {
        return self._marketCapChangePercentage24H.asDriver().map { (data) -> Float in
            return data.zeroOrValue
        }
    }

    var circulatingSupply: Driver<Float> {
        return self._circulatingSupply.asDriver().map { (data) -> Float in
            return data.zeroOrValue
        }
    }

    var totalSupply: Driver<Float> {
        return self._totalSupply.asDriver().map { (data) -> Float in
            return data.zeroOrValue
        }
    }
}
