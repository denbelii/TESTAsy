//
//  ASNetImage.swift
//  ASCollectiTEST
//
//  Created by Nataliia Klemenchenko on 01/04/2017.
//  Copyright © 2017 Andrew Klemenchenko. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ASNetImage: ASNetworkImageNode, ASNetworkImageNodeDelegate {
    
//    init() {
//        super.init()
//        self.delegate = self
//    }
    
    func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
        print("изображение загруженно")
    }
    
    func imageNodeDidStartFetchingData(_ imageNode: ASNetworkImageNode) {
        print("начало загрузки")
    }
}
