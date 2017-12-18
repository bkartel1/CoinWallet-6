//
//  MyValuesTableViewCell.swift
//  CoinWallet
//
//  Created by Mohammad Usman Mughal on 15.12.2017.
//  Copyright © 2017 coderoom. All rights reserved.
//

import UIKit

class MyCoinValuesTableViewCell: UITableViewCell {

    @IBOutlet weak var amountInCoin: UILabel!
    
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinValue: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        if Double(self.amountInCoin.text!)! == 0.0 {
//            self.amountInCoin.isHidden = true
//            self.coinValue.isHidden = true
//            self.coinNameLabel.isHidden = true
//        }
    }
}
