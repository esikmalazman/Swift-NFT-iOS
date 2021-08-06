//
//  UserDefaultsExtensions.swift
//  Swift-NFT
//
//  Created by Ikmal Azman on 06/08/2021.
//

import Foundation

extension UserDefaults {
    // Determine if the key is exist or else
    static func exists(key : String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
