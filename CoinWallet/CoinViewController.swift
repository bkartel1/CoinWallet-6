//
//  ViewController.swift
//  CoinWallet
//
//  Created by Mohammad Usman Mughal on 10.12.2017.
//  Copyright © 2017 coderoom. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coins = [Coin]()
    
    var refreshControl: UIRefreshControl! = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Kurser"
        
        tableView.dataSource = self
        fetchCoins()
        
        refreshControl.backgroundColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(CoinPortofolioViewController.refreshData), for: UIControlEvents.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Updating coin rate")
        self.view.sendSubview(toBack: refreshControl)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        let  url = URL.init(string: "https://api.coinmarketcap.com/v1/ticker/?convert=NOK&limit=10")!
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let task = URLSession.shared.dataTask(with: url) { (data, respone, error) in
            if let actualData = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: actualData, options: .allowFragments) as? [[String : Any]]{
                        
                        var tempCoins = [Coin]()
                        
                        for coinDict in json {
                            
                            if let coin = Coin.fetchOrInsert(attributes: coinDict, managedObjectContext: appDelegate.persistentContainer.viewContext) {
                                
                                tempCoins.append(coin)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.coins = tempCoins
                            self.tableView.reloadData()

                        }
                        
                        appDelegate.saveContext()
                    }
                }catch let error {
                    print(error)
                }
                
            }
        }
        task.resume()
        
    }
    
    @objc func refreshData() {
        fetchCoins()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func fetchCoins(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        do {
            coins = try appDelegate.persistentContainer.viewContext.fetch(Coin.fetchRequest())
            tableView.reloadData()
        } catch let error {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailViewController = segue.destination as? CoinDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            
            let coin = coins[indexPath.row]
            detailViewController.coin = coin
        }
    }
    
    
    
}

extension CoinViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coin = coins[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "showDetails", for: indexPath) as! CoinTableViewCell
        
        cell.coinNameLabel.text = coin.coinName
        cell.coinSymbolLabel.text = coin.coinSymbol
        cell.coinPriceNOKLabel.text = "\(Double(round(1000*coin.coinPriceNOK)/1000)) kr"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }

}

