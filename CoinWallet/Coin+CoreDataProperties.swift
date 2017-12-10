//
//  Coin+CoreDataProperties.swift
//  CoinWallet
//
//  Created by Mohammad Usman Mughal on 10.12.2017.
//  Copyright © 2017 coderoom. All rights reserved.
//
//

import Foundation
import CoreData


extension Coin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coin> {
        return NSFetchRequest<Coin>(entityName: "Coin")
    }

    @NSManaged public var coinID: String?
    @NSManaged public var coinSymbol: String?
    @NSManaged public var coinPriceUSD: Double
    @NSManaged public var coinPriceNOK: Double
    @NSManaged public var coinName: String?
    @NSManaged public var coinChange24h: Double
    @NSManaged public var coinChange7d: Double
    @NSManaged public var coinChange1h: Double

}
