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
        //hideKeyBoardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
