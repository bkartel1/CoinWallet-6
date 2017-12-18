//
//  Coin+CoreDataClass.swift
//  CoinWallet
//
//  Created by Mohammad Usman Mughal on 10.12.2017.
//  Copyright © 2017 coderoom. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Coin)
public class Coin: NSManagedObject {
    
    class func fetchOrInsert (attributes: [String : Any], managedObjectContext: NSManagedObjectContext) -> Coin? {
        
        guard let coinID = attributes["id"] as? String else {
                return nil
        }
        
        let coin: Coin = {
            
            
            let fetchRequest = NSFetchRequest<Coin>(entityName: "Coin")
            
            fetchRequest.predicate = NSPredicate.init(format: "coinID == %@", coinID)
            
            
            
            do {
                let results = try! managedObjectContext.fetch(fetchRequest)
                if results.count > 0 {
                    return results.first!
                } else {
                    let entityDescription = NSEntityDescription.entity(forEntityName: "Coin", in: managedObjectContext)
                    
                    let coin = Coin(entity: entityDescription! , insertInto: managedObjectContext)
                    
                    coin.coinID = coinID
                    
                    return coin
                }
            }
            
        }()
        
        if let coinName = attributes["name"] as? String {
            coin.coinName = coinName
        }
        if  let coinSymbol = attributes["symbol"] as? String {
            coin.coinSymbol = coinSymbol
        }
        if let coinPriceNOK = attributes["price_nok"] as? String {
            coin.coinPriceNOK = Double(coinPriceNOK)!
        }
        if let coinPriceUSD = attributes["price_usd"] as? String {
            coin.coinPriceUSD = Double(coinPriceUSD)!
        }
        if let coinChange1h = attributes["percent_change_1h"] as? String {
            coin.coinChange1h = Double(coinChange1h)!
        }
        if let coinChange24h = attributes["percent_change_24h"] as? String {
            coin.coinChange24h = Double(coinChange24h)!
        }
        if let coinChange7d = attributes["percent_change_7d"] as? String {
            coin.coinChange7d = Double(coinChange7d)!
        }
        
        return coin
    }
    
    class func saveCoin(coinID: String, managedObjectContext: NSManagedObjectContext) -> Coin? {
        
        let fetchRequest = NSFetchRequest<Coin>(entityName: "Coin")
        
        fetchRequest.predicate = NSPredicate.init(format: "coinSymbol == %@", coinID)
        
        fetchRequest.fetchBatchSize = 1
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try! managedObjectContext.fetch(fetchRequest)
            if results.count > 0 {
                if let coinFetch: Coin = results[0] as? Coin {
                    return coinFetch
                }
            }
        }
        return nil
    }
}
