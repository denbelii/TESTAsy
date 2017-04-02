//
//  SegmentedForListLady.swift
//  ASCollectiTEST
//
//  Created by Nataliia Klemenchenko on 02/04/2017.
//  Copyright © 2017 Andrew Klemenchenko. All rights reserved.
//

import UIKit

class SegmentedForListLady: UISegmentedControl {
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        let attributedSelected: [AnyHashable: Any]? = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)]
        let attributedNormal: [AnyHashable: Any]? = [NSForegroundColorAttributeName: #colorLiteral(red: 0.8707963198, green: 0.8707963198, blue: 0.8707963198, alpha: 1), NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)]
        self.setTitleTextAttributes(attributedSelected, for: .selected)
        self.setTitleTextAttributes(attributedNormal, for: .normal)
        
        for item in self.subviews{
            item.tintColor = #colorLiteral(red: 0.462745098, green: 0.7568627451, blue: 0, alpha: 1)
        }
    }
    
}
