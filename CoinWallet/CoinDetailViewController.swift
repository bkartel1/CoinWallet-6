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
    
    @IBOutlet weak var myAmount: UILabel!
    @IBOutlet weak var myValue: UILabel!
    @IBOutlet weak var myAmountLabel: UILabel!
    @IBOutlet weak var myValueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let priceUsd = coin?.coinPriceUSD, let lastHour = coin?.coinChange1h, let last24Hour = coin?.coinChange24h, let last7d = coin?.coinChange7d, let priceNok = coin?.coinPriceNOK {
            priceUSD.text = "\(Double(round(1000*priceUsd)/1000)) $"
            myAmount.text = "\(Double((coin?.myCoinValue)!))"
            myValue.text = "\(Double(round(1000*((coin?.myCoinValue)! * priceNok)/1000)))"
            if lastHour > 0.0 {
                change1h.text = "+\(Double(round(1000*lastHour)/1000))"
            } else {
                change1h.text = "\(Double(round(1000*lastHour)/1000))"
            }
            if last24Hour > 0.0 {
                change24h.text = "+\(Double(round(1000*last24Hour)/1000))"
            } else {
                change24h.text = "\(Double(round(1000*last24Hour)/1000))"
            }
            if last7d > 0.0 {
                change7d.text = "+\(Double(round(1000*last7d)/1000))"
            } else {
                change7d.text = "\(Double(round(1000*last7d)/1000))"
            }
            
        }
        self.coinSymbol.text = coin?.coinSymbol
        self.navigationItem.title = coin?.coinName
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Legg til", style: .plain, target: self, action: #selector(showAlert(_:)))
        
        if Double(self.myAmount.text!)! == 0.0 {
            self.myAmount.isHidden = true
            self.myValue.isHidden = true
            self.myValueLabel.isHidden = true
            self.myAmountLabel.isHidden = true
        }
    }
    
    @objc func showAlert(_ Sender: Any) {
        let alert = UIAlertController(title: "Legg til " + (coin?.coinName!)!, message: "Skriv antall du vil legge til", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Avbryt", style: .cancel, handler: nil))

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Antall"
        })

        alert.addAction(UIAlertAction(title: "Legg til", style: .default, handler: { action in

            if let value = alert.textFields?[0] {
                self.addValue(amount: Double(value.text!)!)
                print("\(value) + \(self.coin?.coinName)")
            } else {
                
            }
        }))

        self.present(alert, animated: true)
    }
    
    func addValue(amount: Double) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if let oneCoin = Coin.saveCoin(coinID: (coin?.coinSymbol)! ,managedObjectContext: appDelegate.persistentContainer.viewContext) {
            oneCoin.myCoinValue += amount
            
            DispatchQueue.main.async {
                self.myAmount.text = "\(Double((oneCoin.myCoinValue)))"
                self.myValue.text =  "\(Double(round(1000*(oneCoin.myCoinValue * oneCoin.coinPriceNOK)/1000))) kr"
                
            }
            appDelegate.saveContext()
        }
        appDelegate.saveContext()
         
    }

}

