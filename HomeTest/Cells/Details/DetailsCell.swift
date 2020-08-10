//
//  DetailsCell.swift
//  HomeTest
//
//  Created by Steven on 8/9/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {

    static let nibName = "DetailsCell"
    static let cellIdentifier = "DetailsCell"
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
