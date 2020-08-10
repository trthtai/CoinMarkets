//
//  ApiLinks.swift
//  HomeTest
//
//  Created by Steven on 8/7/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation

class ApiLinks {
    static let HOST = "https://api.coingecko.com"
    
    static let FETCH_COINS_MARKETS = RequestUrl(uri: "/api/v3/coins/markets", host: ApiLinks.HOST, requestMethod: .get)
}
