//
//  Lady.swift
//  AlamaFireTest2
//
//  Created by Nataliia Klemenchenko on 30.03.17.
//  Copyright © 2017 tingoit. All rights reserved.
//

import Foundation
import SwiftyJSON
let null = "null"
class Lady {
    
    let id: Int?
    let name: String?
    let age: Int16?
    let weight: String?
    let avatarURL: URL?
    let aboutMe: String?
    let country: String?
    let city: String?
    let height: String?
    let online: Bool?
    let onlineCam: Bool?
    let isFavorites: Bool?
    let imageCount: Int16?
    let videoCount: Int16?
    
    init(id: String?, online: Int8?, onlineCam: Int8?, name: String?, age: String?, weight: String?, avatarURL: String?, aboutMe: String?, country: String?, city: String?, height: String?, isFavorites: String?, imageCount: String?,  videoCount: String?) {
        if let id = id{
            self.id = (id == null || id == "") ? nil : Int(id)
        } else{
            self.id = nil
        }
        if let online = online{
            self.online = online == 1
        } else{
            self.online = nil
        }
        
        if let onlineCam = onlineCam{
            self.onlineCam = onlineCam == 1
        } else{
            self.onlineCam = nil
        }
        
        if let isFavorites = isFavorites{
            let statusisFavorites = (isFavorites == null || isFavorites == "") ? nil : Int8(isFavorites)
            self.isFavorites = statusisFavorites == 1
        } else{
            self.isFavorites = nil
        }
        
        self.name = name == null ? nil : name
        if let age = age{
            self.age = (age == null || age == "") ? nil : Int16(age)
        } else{
            self.age = nil
        }
        
        if let imageCount = imageCount{
            self.imageCount = (imageCount == null || imageCount == "") ? nil : Int16(imageCount)
        } else{
            self.imageCount = nil
        }
        
        if let videoCount = videoCount{
            self.videoCount = (videoCount == null || videoCount == "") ? nil : Int16(videoCount)
        } else{
            self.videoCount = nil
        }
        
        self.weight = weight == null ? nil : weight
        
        
        if let avatarURL = avatarURL{
            self.avatarURL = avatarURL == null ? nil : URL(string: urlPrefixMainPhoto + avatarURL)
        } else{
            self.avatarURL = nil
        }
        
        self.aboutMe = aboutMe == null ? nil : aboutMe
        self.country = country == null ? nil : country
        self.city = city == null ? nil : city
        self.height = height == null ? nil : height
    }
    
    convenience init(json: JSON, id: String? = nil){
        let idSend = id == nil ? json["lady_id"].string : id
        self.init(id: idSend, online: json["online"].int8, onlineCam: json["online_cam"].int8, name: json["pfl_fname"].string, age: json["age"].string, weight: json["weight"].string, avatarURL: json["avatar"].string, aboutMe: json["pfl_about_me"].string, country: json["country"].string, city: json["city"].string, height: json["height"].string, isFavorites: json["is_favorites"].string, imageCount: json["image_count"].string, videoCount: json["video_count"].string)
    }
    
}
