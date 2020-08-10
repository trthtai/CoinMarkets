//
//  ViewController.swift
//  HomeTest
//
//  Created by Steven on 8/7/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let pageSize = 50
    var currentPage = 0
    
    let coinsMarketsViewModel = CoinsMarketsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupTableView()
        self.bindingViewModelWithUI()
        self.fetchMarketData() {
            self.fetchMarketData()
        }
    }
    
    func fetchMarketData(completion: (() -> Void)? = nil) {
        self.currentPage += 1
        self.coinsMarketsViewModel.getCoinsMarkets(pageSize: self.pageSize, page: self.currentPage, completion: completion)
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: CoinCell.nibName, bundle: nil), forCellReuseIdentifier: CoinCell.cellIdentifier)
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.tableView.accessibilityIdentifier = "CoinsMarketsTableView"
        
        self.tableView.rx.modelSelected(Coin.self).subscribe(onNext: { (coin) in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detailsViewController = storyBoard.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
            detailsViewController.coinViewModel = CoinViewModel(coin: coin)
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }).disposed(by: self.disposeBag)
    }

    func bindingViewModelWithUI() {
        self.coinsMarketsViewModel.coins
            .do()
            .drive(self.tableView.rx.items(cellIdentifier: CoinCell.cellIdentifier, cellType: CoinCell.self)) { row, item, cell in
                cell.selectionStyle = .none
                cell.accessibilityIdentifier = "\(item.name)"
                cell.labelName.text = item.name
                cell.labelRank.text = "\(item.marketCapRank)"
                cell.labelPrice.text = "\(item.currentPrice)"
                
                if let url = URL(string: item.image) {
                    cell.avatarView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                        cell.setNeedsLayout()
                    }
                }
            }
            .disposed(by: self.disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row >= (self.currentPage - 1) * self.pageSize) {
            self.fetchMarketData()
        }
    }
}
