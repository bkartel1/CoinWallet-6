//
//  CoinPortofolioViewController.swift
//  CoinWallet
//
//  Created by Mohammad Usman Mughal on 10.12.2017.
//  Copyright © 2017 coderoom. All rights reserved.
//

import UIKit

class CoinPortofolioViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    
    var portofolioCoins = [Coin]()
    
    var refreshControl: UIRefreshControl! = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMyCoinValues()
        tableView.dataSource = self
        
        getTotalValue()
        
        navigationItem.rightBarButtonItem = editButtonItem
        self.title = "Portefølje"
        
        refreshControl.backgroundColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(CoinPortofolioViewController.refreshData), for: UIControlEvents.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Updating coin values")
        self.view.sendSubview(toBack: refreshControl)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        
    }
    
    @objc func refreshData() {
        getTotalValue()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func fetchMyCoinValues(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        do {
            portofolioCoins = try appDelegate.persistentContainer.viewContext.fetch(Coin.fetchRequest())
            tableView.reloadData()
        } catch let error {
            print(error)
        }
    }
    
    func getTotalValue() {
        fetchMyCoinValues()
        
        var totalSum = 0.0
        
        for coins in portofolioCoins {
            let amount = coins.myCoinValue
            let value = coins.coinPriceNOK
            
            let sumCoins = amount*value
            totalSum += sumCoins
            print(totalSum)
        }
        
        self.totalValue.text = String(round(1000*(totalSum)/1000)) + " kr"
    }
    
    func updateValue(amount: Double, ID: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if let oneCoin = Coin.saveCoin(coinID: (ID) ,managedObjectContext: appDelegate.persistentContainer.viewContext) {
            
            oneCoin.myCoinValue -= amount
        }
        appDelegate.saveContext()
        getTotalValue()
        tableView.reloadData()
    }

}

extension CoinPortofolioViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portofolioCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coins = portofolioCoins[indexPath.row]
        
        let myCoins = tableView.dequeueReusableCell(withIdentifier: "myCoinValues", for: indexPath) as! MyCoinValuesTableViewCell
        
        myCoins.coinNameLabel.text = coins.coinName
        myCoins.amountInCoin.text = "\(Double(coins.myCoinValue))"
        myCoins.coinValue.text = "\(Double(round(1000*(coins.myCoinValue * coins.coinPriceNOK)/1000))) kr"
        
        return myCoins
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let coins = portofolioCoins[indexPath.row]
        
        let alert = UIAlertController(title: "Endre portefølje", message: "Skriv antall \(coins.coinName!) du vil endre", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Avbryt", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Antall"
        })
        alert.addAction(UIAlertAction(title: "Endre", style: .default, handler: { action in
            
            if let value = alert.textFields?[0] {
                self.updateValue(amount: Double(value.text!)!, ID: coins.coinID!)
                print("\(value) + \(coins.coinName!)")
            } else {
            }
        }))
        
        self.present(alert, animated: true)
        
    }
}
