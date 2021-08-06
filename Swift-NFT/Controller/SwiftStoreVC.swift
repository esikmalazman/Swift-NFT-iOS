//
//  SwiftStoreVC.swift
//  Swift-NFT
//
//  Created by Ikmal Azman on 04/08/2021.
//

import UIKit
import StoreKit

class SwiftStoreVC: UIViewController {
    
    var store = Store()
    var totalCoins : Int?
    var initialCoins : Int = 0


    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Assign SKPaymentTransactionObserver delegate to the VC
        SKPaymentQueue.default().add(self)
    }
    
    func didPurchasedCoins(at package : String) {
        // Identify if user can make payments
        if SKPaymentQueue.canMakePayments() {
            /// User can make payments
            
            // Identify product ad make request to App Store for payment process
            let paymentRequest = SKMutablePayment()
            // Specify the product for payment request
            paymentRequest.productIdentifier = package
            // Add payment request to StoreKit queue
            SKPaymentQueue.default().add(paymentRequest)
            
        } else {
            /// User cannot make payments
        }
    }
    
    // Probably error here
    func calculateCoins(from purchaseCoins: Int) -> Int {
        
        
        print("purchaseCoins : \(purchaseCoins)")
        
        let walletsBalance = UserDefaults.standard.bool(forKey: "wallets")
        print("coinsAvailable \(walletsBalance)")
        
        if UserDefaults.exists(key: "wallets") {
            
            initialCoins = UserDefaults.standard.integer(forKey: "wallets")
            totalCoins = initialCoins + purchaseCoins
            print("Total Coins : \(totalCoins!)")
            
            return totalCoins!
            
        } else {
            
            totalCoins = initialCoins + purchaseCoins
            print("Total Coins : \(totalCoins!)")
            return totalCoins!
        }
    }
    
    func getProductID(from coins : String) -> String {
        
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
        
        print("getCoinsFromProductID : \(coins)")
        let savedCoins  = calculateCoins(from: coins)
        UserDefaults.standard.set(savedCoins, forKey: "wallets")
        print("Calculated coins : \(savedCoins)")
        print("Saved coins = \(UserDefaults.standard.integer(forKey: "wallets"))")
        
    }
}

//MARK:- IAP menthods
// Allow to return status of transactioan process, unlock some functionality
extension SwiftStoreVC : SKPaymentTransactionObserver {
    
    // Allow to manage process after transaction status return
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        // Looping status of each transcation
        for transaction in transactions {
            
            if transaction.transactionState == .purchased {
                
                /// Payment Success
                print("Payment Success")
                
                // TODO : Add method to be active after purchase succes
                // - Save to user defaults, Update coin value
                let transactionId = transaction.payment.productIdentifier
                print("Transaction Id : \(transactionId)")
                getCoinsFromProductID(from: transactionId)
                //print("Coins After Transaction Success: \(coins)")
                
                //let calculatedCoins = calculateCoins(from: coins)
                //print("Total coins before  save to UserDefautlts : \(calculatedCoins)")
                
                // End payment queue from App Store
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .failed {
                /// Payment Failed
                print("Payment Failed")
                
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
}

//MARK:- UICollectionView DataSource
extension SwiftStoreVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.swiftConsumables.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let listOfSwiftCoin = store.swiftConsumables[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SwiftiesCoinCell
        
        cell.coinsImage.image = listOfSwiftCoin.image
        cell.coinsValue.text = listOfSwiftCoin.coin
        cell.price.text = listOfSwiftCoin.price
        
        return cell
    }
}

extension SwiftStoreVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Locate what purchases to be triggered
        let coins = store.swiftConsumables[indexPath.row].coin
        let productId = getProductID(from: coins)
        
        didPurchasedCoins(at: productId)
        
        print("Coin selected : \(coins), Product ID : \(productId)")
    }
    
    
}

