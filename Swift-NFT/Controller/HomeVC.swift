//
//  ViewController.swift
//  Swift-NFT
//
//  Created by Ikmal Azman on 04/08/2021.
//

import UIKit

class HomeVC : UIViewController {
    
    
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var swiftiesCoin: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        didHaveSwifties()
        setupView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didHaveSwifties() {
        
        if let swiftWallet =  UserDefaults.standard.object(forKey: "wallets") as? Int {
            swiftiesCoin.text = "\(swiftWallet)"
        }
    }
    
    func setupView() {
        cardName.text = "Tim Swift"
        cardNumber.text = "SW32 2013 0012 6745"
        
        navigationController?.navigationBar.largeTitleTextAttributes =
            [
                NSAttributedString.Key.foregroundColor : UIColor(red: 1.0, green: 0.6, blue: 0.14, alpha: 1),
                NSAttributedString.Key.font : UIFont(name: "Inter-SemiBold", size: 40)!
            ]
        navigationController?.navigationBar.tintColor = .black
    }
}

