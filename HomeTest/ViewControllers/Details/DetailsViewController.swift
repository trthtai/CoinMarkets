//
//  DetailsViewController.swift
//  HomeTest
//
//  Created by Steven on 8/9/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coinViewModel: CoinViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupTableView()
        self.bindingViewModelWithUI()
    }
    
    func setupNavigationBar() {
        self.coinViewModel.name.drive(self.navigationItem.rx.title).disposed(by: self.disposeBag)
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: DetailsCell.nibName, bundle: nil), forCellReuseIdentifier: DetailsCell.cellIdentifier)
    }

    func bindingViewModelWithUI() {
        self.coinViewModel.headersAndValues
            .do()
            .drive(self.tableView.rx.items(cellIdentifier: DetailsCell.cellIdentifier, cellType: DetailsCell.self)) { row, item, cell in
                cell.selectionStyle = .none
                cell.labelName.text = item.title
                cell.labelValue.text = item.value
            }
            .disposed(by: self.disposeBag)
    }
}
