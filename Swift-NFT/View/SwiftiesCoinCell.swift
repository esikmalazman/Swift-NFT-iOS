//
//  SwiftiesCoinCell.swift
//  Swift-NFT
//
//  Created by Ikmal Azman on 04/08/2021.
//

import UIKit

class SwiftiesCoinCell: UICollectionViewCell {
    
    @IBOutlet weak var coinsImage: UIImageView!
    @IBOutlet weak var coinsValue: UILabel!
    @IBOutlet weak var price: UILabel!
    
    let cellBackgroundImage : UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cell-background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView = cellBackgroundImage
     
    }
}
