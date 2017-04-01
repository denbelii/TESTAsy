//
//  UtilityConst.swift
//  AlamaFireTest2
//
//  Created by Андрей on 28.03.17.
//  Copyright © 2017 tingoit. All rights reserved.
//

import Foundation
import Alamofire

let urlMain = "https://www.bridge-of-love.com/api"
let urlPrefixMainPhoto = "https://www.bridge-of-love.com/"
let userName = "alex572481@gmail.com"
let password = "alex572481"

var AUTH_TOKEN: String?{
    return KeyChain.getToken()
}
let AUTH_TOKEN_KEY = "X-Token"

var headers: HTTPHeaders {
    if let AUTH_TOKEN = AUTH_TOKEN{
        return [AUTH_TOKEN_KEY : AUTH_TOKEN]
    }
    print("AUTH_TOKEN_KEY is nil")
    return [AUTH_TOKEN_KEY : "Error"]
}
