//
//  ApiCoins.swift
//  HomeTest
//
//  Created by Steven on 8/9/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation
import RxSwift

class ApiCoins: RestfulHandler {
    static func getCoinsMarkets(pageSize: Int, page: Int) -> Observable<ApiResult<[Coin], String>> {
        let parameters: [String : Any] = [
            "vs_currency": "usd",
            "per_page": pageSize,
            "page": page,
            "order": "market_cap_desc"
        ]
        let api = ApiCoins(requestUrl: ApiLinks.FETCH_COINS_MARKETS, parameters: parameters)
        return api.request(ofType: [Coin].self)
    }
}
