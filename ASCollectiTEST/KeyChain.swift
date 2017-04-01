//
//  KeyChain.swift
//  AlamaFireTest2
//
//  Created by Nataliia Klemenchenko on 29.03.17.
//  Copyright © 2017 tingoit. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

final class KeyChain{
    static let tokenKeyIdentifier = "tokenKey"
    
    static func setToken(tokenKey: String){
        let saveSuccessful: Bool = KeychainWrapper.standard.set(tokenKey, forKey: tokenKeyIdentifier)
        if saveSuccessful{
            print("tokenKey record")
        }
    }
    
    static func getToken() -> String?{
        let tokenKey: String? = KeychainWrapper.standard.string(forKey: tokenKeyIdentifier)
        return tokenKey
    }
    
    static func removeToken(){
        let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: tokenKeyIdentifier)
        if removeSuccessful{
            print("Token remove")
        }
    }
    
}
