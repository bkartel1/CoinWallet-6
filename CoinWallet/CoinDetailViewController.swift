//
//  CoinDetailViewController.swift
//  CoinWallet
//
//  Created by Mohammad Usman Mughal on 10.12.2017.
//  Copyright © 2017 coderoom. All rights reserved.
//

import UIKit

class CoinDetailViewController: UIViewController {
    
    var coin : Coin?
    
    @IBOutlet weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var coinSymbol: UILabel!
    
    @IBOutlet weak var priceUSDLabel: UILabel!
    @IBOutlet weak var priceUSD: UILabel!
    
    @IBOutlet weak var change1hLabel: UILabel!
    @IBOutlet weak var change1h: UILabel!
    
    @IBOutlet weak var change24hLabel: UILabel!
    @IBOutlet weak var change24h: UILabel!
    
    @IBOutlet weak var change7dLabel: UILabel!
    @IBOutlet weak var change7d: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let priceUsd = coin?.coinPriceUSD {
            priceUSD.text = "\(Double(round(1000*priceUsd)/1000)) $"
        }

        if let lastHour = coin?.coinChange1h {
            change1h.text = "\(Double(round(1000*lastHour)/1000)) $"
        }
        
        if let last24Hour = coin?.coinChange24h {
            change24h.text = "\(Double(round(1000*last24Hour)/1000)) $"
        }
        
        if let last7d = coin?.coinChange7d {
            change7d.text = "\(Double(round(1000*last7d)/1000)) $"
        }
        self.coinSymbol.text = coin?.coinSymbol
        self.coinSymbolLabel.text = "Symbol"
        self.priceUSDLabel.text = "Pris i USD"
        self.change1hLabel.text = "Siste time"
        self.change24hLabel.text = "Siste 24 timer"
        self.change7dLabel.text = "Siste 7 dager"
        // self.navigationItem.coinSymbolLabel.text = coin?.coinName
    }


}
