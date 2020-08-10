//
//  CoinCell.swift
//  HomeTest
//
//  Created by Steven on 8/9/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class CoinCell: UITableViewCell {
    
    static let nibName = "CoinCell"
    static let cellIdentifier = "CoinCell"

    @IBOutlet weak var labelRank: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
