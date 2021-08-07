//
//  SwiftStoreVC.swift
//  Swift-NFT
//
//  Created by Ikmal Azman on 04/08/2021.
//

import UIKit
import StoreKit

class SwiftStoreVC: UIViewController {
    
    var storeData = Store()
    var storeManager = StoreManager()
    
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
                
                let transactionId = transaction.payment.productIdentifier
                print("Transaction Id : \(transactionId)")
                storeManager.getCoinsFromProductID(from: transactionId)
                
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
        return storeData.consumables().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let listOfSwiftCoin = storeData.consumables()[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SwiftiesCoinCell
        
        cell.coinsImage.image = listOfSwiftCoin.image
        cell.coinsValue.text = "\(listOfSwiftCoin.coin) Swifties"
        cell.price.text = listOfSwiftCoin.price
        
        
        
        return cell
    }
}

extension SwiftStoreVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Locate what purchases to be triggered
        let selectedCoins = storeData.consumables()[indexPath.row].coin
        let productId = storeManager.getProductIDFromCoins(from: selectedCoins)
        
        didPurchasedCoins(at: productId)
        
        print("Coin selected : \(selectedCoins), Product ID : \(productId)")
    }
}

