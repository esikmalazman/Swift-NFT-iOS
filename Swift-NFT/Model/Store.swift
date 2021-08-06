//
//  Consumables.swift
//  Swift-NFT
//
//  Created by Ikmal Azman on 06/08/2021.
//

import UIKit

class Store {
     
    //MARK:- DataSource
let swiftConsumables : [Consumables] =
        [
            Consumables(image: UIImage(named: "swifties-100")!, coin: "100", price: "RM 3.90"),
            Consumables(image: UIImage(named: "swifties-300")!, coin: "300", price: "RM 12.90"),
            Consumables(image: UIImage(named: "swifties-1000")!, coin: "1000", price: "RM 39.90"),
            Consumables(image: UIImage(named: "swifties-3000")!, coin: "3000", price: "RM 69.90")
        ]
    
    
    //MARK:- Instance Methods
    func consumables() -> [Consumables] {
        return swiftConsumables
    }
}
