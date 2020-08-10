
//
//  CoinsMarketsTests.swift
//  HomeTestTests
//
//  Created by Steven on 8/10/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation
import XCTest
import RxTest
import RxSwift
import RxBlocking
import OHHTTPStubs
import RealmSwift

@testable import HomeTest

class CoinsMarketsViewModelTests: XCTestCase {

    var coinsMarketsViewModel: CoinsMarketsViewModel!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.coinsMarketsViewModel = CoinsMarketsViewModel()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "CoinsMarketsViewModelsRealm"
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.disposeBag = nil
        self.scheduler = nil
        self.coinsMarketsViewModel = nil
    }
    
    private func initCoin(id: Int) -> Coin {
        let coin = Coin()
        coin.id = "Coin_Test_Id_\(id)"
        coin.symbol = "Coin_Test_Symbol_\(id)"
        coin.name = "Coin_Test_Name_\(id)"
        coin.image = "Coin_Test_Image_\(id)"
        coin.currentPrice = 1
        coin.marketCap = OptionalFloat(numeric: 2)
        coin.marketCapRank = id
        coin.totalVolume = 4
        coin.high24H = OptionalFloat(numeric: 5)
        coin.low24H = OptionalFloat(numeric: 6)
        coin.priceChange24H = OptionalFloat(numeric: 7)
        coin.priceChangePercentage24H = OptionalFloat(numeric: 8)
        coin.marketCapChange24H = OptionalFloat(numeric: 9)
        coin.marketCapChangePercentage24H = OptionalFloat(numeric: 10)
        coin.circulatingSupply = OptionalFloat(numeric: 11)
        coin.totalSupply = OptionalFloat(numeric: 12)
        return coin
    }
    
    private func getCoinsMarketsData() -> [[String : Any]] {
        return [
          [
            "id": "Coin_Test_Id_1",
            "symbol": "Coin_Test_Symbol_1",
            "name": "Coin_Test_Name_1",
            "image": "Coin_Test_Image_1",
            "current_price": 1,
            "market_cap": 2,
            "market_cap_rank": 1,
            "total_volume": 4,
            "high_24h": 5,
            "low_24h": 6,
            "price_change_24h": 7,
            "price_change_percentage_24h": 8,
            "market_cap_change_24h": 9,
            "market_cap_change_percentage_24h": 10,
            "circulating_supply": 11,
            "total_supply": 12,
          ],
          [
            "id": "Coin_Test_Id_2",
            "symbol": "Coin_Test_Symbol_2",
            "name": "Coin_Test_Name_2",
            "image": "Coin_Test_Image_2",
            "current_price": 1,
            "market_cap": 2,
            "market_cap_rank": 2,
            "total_volume": 4,
            "high_24h": 5,
            "low_24h": 6,
            "price_change_24h": 7,
            "price_change_percentage_24h": 8,
            "market_cap_change_24h": 9,
            "market_cap_change_percentage_24h": 10,
            "circulating_supply": 11,
            "total_supply": 12,
          ]
        ]
    }
    
    func testGetCoinsMarkets() throws {
        stub(condition: isHost(ApiLinks.HOST.replacingOccurrences(of: "https://", with: ""))) { (request) -> HTTPStubsResponse in
            let json = self.getCoinsMarketsData()
            return HTTPStubsResponse(jsonObject: json, statusCode: 200, headers: nil)
        }

        let testExpectation = expectation(description: "Asynchronous expectation")
        self.coinsMarketsViewModel.getCoinsMarkets(pageSize: 1, page: 1) {
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: .none)

        var expectedResult = [Coin]()
        expectedResult.append(self.initCoin(id: 1))
        expectedResult.append(self.initCoin(id: 2))
        
        self.coinsMarketsViewModel.coins.drive(onNext: { (data) in
            XCTAssertEqual(data.description, expectedResult.description)
            XCTAssertEqual(self.coinsMarketsViewModel.coinsSize, data.count)
            
            let realm = try! Realm()
            let objects = realm.objects(Coin.self).sorted { (one, two) -> Bool in
                return one.marketCapRank < two.marketCapRank
            }
            XCTAssertEqual(data.description, objects.description)
        }).disposed(by: self.disposeBag)
    }

}
