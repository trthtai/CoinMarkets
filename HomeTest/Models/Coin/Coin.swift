//
//  Coin.swift
//  HomeTest
//
//  Created by Steven on 8/9/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation
import RealmSwift

class OptionalFloat: Object, Decodable {
    private var numeric = RealmOptional<Float>()

    required init() {
        super.init()
    }
    
    init(numeric: Float) {
        super.init()
        self.numeric = RealmOptional<Float>(numeric)
    }
    
    required public convenience init(from decoder: Decoder) throws {
        self.init()

        let singleValueContainer = try decoder.singleValueContainer()
        if singleValueContainer.decodeNil() == false {
            let value = try singleValueContainer.decode(Float.self)
            numeric = RealmOptional(value)
        }
    }

    var value: Float? {
        return numeric.value
    }

    var zeroOrValue: Float {
        return numeric.value ?? 0
    }
}

class Coin: Object, Decodable {
    @objc dynamic var id: String = ""
    @objc dynamic var symbol: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var currentPrice: Float = 0
    @objc dynamic var marketCap: OptionalFloat?
    @objc dynamic var marketCapRank: Int = 0
    @objc dynamic var totalVolume: Float = 0
    @objc dynamic var high24H: OptionalFloat?
    @objc dynamic var low24H: OptionalFloat?
    @objc dynamic var priceChange24H: OptionalFloat?
    @objc dynamic var priceChangePercentage24H: OptionalFloat?
    @objc dynamic var marketCapChange24H: OptionalFloat?
    @objc dynamic var marketCapChangePercentage24H: OptionalFloat?
    @objc dynamic var circulatingSupply: OptionalFloat?
    @objc dynamic var totalSupply: OptionalFloat?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
