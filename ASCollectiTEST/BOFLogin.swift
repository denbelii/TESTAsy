//
//  BOFLogin.swift
//  AlamaFireTest2
//
//  Created by Андрей on 28.03.17.
//  Copyright © 2017 tingoit. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BOFLogin{
    
    let loginUrl = urlMain + "/index.php?app=default&act=login"
    let userName: String
    let password: String
    var sessionId: String?
    var parameters: Parameters{
        return ["user_name": self.userName, "password": self.password]
    }
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
    func fetchTokenKey(completionHandler: @escaping (_ tokenKey: String?) -> Void) {
        //print("completionHandler(tokenKey) ")
        PostRequest.fetchData(url: loginUrl, parameters: parameters){ json in
            
            if let code = json["code"].int{
               
                switch code{
                case 200:
                    //ok
                    
                    if let tokenKey = json["data"]["session_id"].string{
                        
                        completionHandler(tokenKey)
                        
                    }else{
                        print("Error with tokenKey - nil!")
                        completionHandler(nil)
                    }
                case 406:
                    //not good
                    if let message = json["message"].string{
                        print(message)
                    }
                    completionHandler(nil)
                default:
                    print("Code unavailable")
                    completionHandler(nil)
                }
            }else{
                print("Code nil")
                completionHandler(nil)
            }
        }
    }
    
}
