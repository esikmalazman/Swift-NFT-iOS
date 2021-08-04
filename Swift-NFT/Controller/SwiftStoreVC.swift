//
//  SwiftStoreVC.swift
//  Swift-NFT
//
//  Created by Ikmal Azman on 04/08/2021.
//

import UIKit

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
        
        print("Coins : \(swiftModel[indexPath.row].coin)")
    }
}

