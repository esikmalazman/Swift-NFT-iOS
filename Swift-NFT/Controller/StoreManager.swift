//
//  StoreController.swift
//  Swift-NFT
//
//  Created by Ikmal Azman on 06/08/2021.
//

import Foundation
import StoreKit


class StoreManager {
    
    var totalCoins : Int?
    var initialCoins : Int = 0
    
    func calculateCoins(from purchaseCoins: Int) -> Int {
        
        if isCoinsPurchased("wallets") {
            
            initialCoins = UserDefaults.standard.integer(forKey: "wallets")
            totalCoins = initialCoins + purchaseCoins
            
            return totalCoins ?? 0
        } else {
            
            totalCoins = initialCoins + purchaseCoins
            return totalCoins ?? 0
        }
    }
    
    func getProductIDFromCoins(from coins : String) -> String {
        
        var productID : String  {
            switch coins {
            case "100":
                return Constants.ProductID.swifties_100
            case "300":
                return Constants.ProductID.swifties_300
            case "1000":
                return Constants.ProductID.swifties_300
            case "3000":
                return Constants.ProductID.swifties_3000
            default:
                return "There's no productID for selected packaged"
            }
        }
        return productID
    }
    
    func getCoinsFromProductID(from productId : String)  {
        
        var coins : Int  {
            switch productId {
            case Constants.ProductID.swifties_100:
                return 100
            case Constants.ProductID.swifties_300:
                return 300
            case Constants.ProductID.swifties_1000:
                return 1000
            case Constants.ProductID.swifties_3000:
                return 3000
            default:
                return 0
            }
        }
        
        let calculatedCoins  = calculateCoins(from: coins)
        savePurchasedCoins(calculatedCoins, "wallets")
        print("Coins in Wallet = \(UserDefaults.standard.integer(forKey: "wallets"))")
        
    }
    
    func savePurchasedCoins(_ value : Any?, _ key : String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func isCoinsPurchased(_ key : String) -> Bool {
        UserDefaults.exists(key: key)
    }
}


