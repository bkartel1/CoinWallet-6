//
//  CoinTableViewCell.swift
//  CoinWallet
//
//  Created by Mohammad Usman Mughal on 10.12.2017.
//  Copyright © 2017 coderoom. All rights reserved.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var coinPriceNOKLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
