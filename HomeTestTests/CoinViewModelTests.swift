//
//  CoinViewModelTests.swift
//  HomeTestTests
//
//  Created by Steven on 8/10/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking

@testable import HomeTest

class CoinViewModelTests: XCTestCase {
    
    var coin: Coin!
    var coinViewModel: CoinViewModel!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        self.initCoin()
        self.disposeBag = DisposeBag()
        self.coinViewModel = CoinViewModel(coin: self.coin)
    }

    private func initCoin() {
        self.coin = Coin()
        self.coin.id = "Coin_Test_Id"
        self.coin.symbol = "Coin_Test_Symbol"
        self.coin.name = "Coin_Test_Name"
        self.coin.image = "coin-test-image"
        self.coin.currentPrice = 1
        self.coin.marketCap = OptionalFloat(numeric: 2)
        self.coin.marketCapRank = 3
        self.coin.totalVolume = 4
        self.coin.high24H = OptionalFloat(numeric: 5)
        self.coin.low24H = OptionalFloat(numeric: 6)
        self.coin.priceChange24H = OptionalFloat(numeric: 7)
        self.coin.priceChangePercentage24H = OptionalFloat(numeric: 8)
        self.coin.marketCapChange24H = OptionalFloat(numeric: 9)
        self.coin.marketCapChangePercentage24H = OptionalFloat(numeric: 10)
        self.coin.circulatingSupply = OptionalFloat(numeric: 11)
        self.coin.totalSupply = OptionalFloat(numeric: 12)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.coin = nil
        self.coinViewModel = nil
        self.disposeBag = nil
    }

    func testHeadersAndValues() throws {
        var expectedData: [DetailsHeader] = []
        expectedData.append(DetailsHeader(title: "Name", value: "Coin_Test_Name"))
        expectedData.append(DetailsHeader(title: "Symbol", value: "Coin_Test_Symbol"))
        expectedData.append(DetailsHeader(title: "Current Price", value: "1"))
        expectedData.append(DetailsHeader(title: "Market Cap", value: "2"))
        expectedData.append(DetailsHeader(title: "Market Capp Rank", value: "3"))
        expectedData.append(DetailsHeader(title: "Total Volume", value: "4"))
        expectedData.append(DetailsHeader(title: "High 24h", value: "5"))
        expectedData.append(DetailsHeader(title: "Low 24h", value: "6"))
        expectedData.append(DetailsHeader(title: "Price Change 24h", value: "7"))
        expectedData.append(DetailsHeader(title: "Price Change Percentage 24h", value: "800%"))
        expectedData.append(DetailsHeader(title: "Market Cap Change 24h", value: "9"))
        expectedData.append(DetailsHeader(title: "Market Cap Change Percentage 24h", value: "1000%"))
        expectedData.append(DetailsHeader(title: "Circulating Supply", value: "11"))
        expectedData.append(DetailsHeader(title: "Total Supply", value: "12"))
        
        XCTAssertEqual(try self.coinViewModel.headersAndValues.toBlocking().first(), expectedData)
    }

}
