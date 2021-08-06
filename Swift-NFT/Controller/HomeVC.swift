//
//  ViewController.swift
//  Swift-NFT
//
//  Created by Ikmal Azman on 04/08/2021.
//

import UIKit

class HomeVC : UIViewController {


    @IBOutlet weak var swiftiesCoin: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        didHaveSwifties()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didHaveSwifties() {
        
        if let swiftWallet =  UserDefaults.standard.object(forKey: "wallets") as? Int {
            swiftiesCoin.text = "\(swiftWallet)"
        }
    }

    @IBAction func topupPressed(_ sender: UIButton) {
        
    
    }
    
    
}

