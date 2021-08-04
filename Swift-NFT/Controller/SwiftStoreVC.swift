//
//  SwiftStoreVC.swift
//  Swift-NFT
//
//  Created by Ikmal Azman on 04/08/2021.
//

import UIKit
import StoreKit

class SwiftStoreVC: UIViewController {

    
    let swiftModel : [SwiftiesCoin] =
        [
            SwiftiesCoin(image: UIImage(named: "swifties-100")!, coin: "100", price: "RM 3.90"),
            SwiftiesCoin(image: UIImage(named: "swifties-300")!, coin: "300", price: "RM 12.90"),
            SwiftiesCoin(image: UIImage(named: "swifties-1000")!, coin: "1000", price: "RM 39.90"),
            SwiftiesCoin(image: UIImage(named: "swifties-3000")!, coin: "3000", price: "RM 69.90")
        ]

   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Assign SKPaymentTransactionObserver delegate to the VC
        SKPaymentQueue.default().add(self)
    }
    
    func didBuySelectedCoins(at package : String) {
        
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
                
                // TODO : Add method to be active after purchase succes
                // - Save to user defaults, Update coin value
                
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
        return swiftModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let listOfSwiftCoin = swiftModel[indexPath.row]
        
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
        let coins = swiftModel[indexPath.row].coin
        
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
   
        didBuySelectedCoins(at: productID)
        
        print("Coins : \(coins), Product ID : \(productID)")
    }
}

