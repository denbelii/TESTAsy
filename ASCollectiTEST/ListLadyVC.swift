//
//  ListLadyVC.swift
//  ASCollectiTEST
//
//  Created by Nataliia Klemenchenko on 02/04/2017.
//  Copyright © 2017 Andrew Klemenchenko. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ListLadyVC: UIViewController{

    @IBOutlet weak var conteinerForListLady: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contollerChild = ASVC()
        addChildViewController(contollerChild)
        conteinerForListLady.addSubview(contollerChild.view)
        contollerChild.delegate = self
        
        contollerChild.view.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: Any] = ["contollerChildView": contollerChild.view, "parentView": conteinerForListLady]
        
        //["contollerChildView": contollerChild.view,
                     //"parentView": conteinerForListLady]
        
        let constraintForCollectionV = NSLayoutConstraint.constraints(withVisualFormat: "V:|[contollerChildView]|", options: [], metrics: nil, views: views)
        let constraintForCollectionH = NSLayoutConstraint.constraints(withVisualFormat: "H:|[contollerChildView]|", options: [], metrics: nil, views: views)
        
        conteinerForListLady.addConstraints(constraintForCollectionV)
        conteinerForListLady.addConstraints(constraintForCollectionH)
        
        hideKeyBoardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ListLadyVC: UpdateListLady{
    func updateListLady() {
    }
}

protocol UpdateListLady {
    func updateListLady()
}
