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
    
    override func layoutSubviews() {
        configureLayout()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView = cellBackgroundImage
        
    }
    override func prepareForReuse() {
        configureForReuse()
    }
    func configureLayout(){
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.borderWidth = 0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0.01
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    func configureForReuse(){
        
        coinsImage.image = nil
        coinsValue.text = nil
        price.text = nil
        
    }
}
