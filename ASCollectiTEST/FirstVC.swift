//
//  FirstVC.swift
//  ASCollectiTEST
//
//  Created by Nataliia Klemenchenko on 31.03.17.
//  Copyright © 2017 Andrew Klemenchenko. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goSecond(_ sender: Any) {
        goSecond()
    }

    func goSecond(){
        
        BOFLogin(userName: userName, password: password).fetchTokenKey { (tokenKey) in
            //print("tokenKey = \(tokenKey)")
            if let tokenKey = tokenKey{
                KeyChain.setToken(tokenKey: tokenKey)
                
            }
        }
        let vc = ASVC()
        //let vc = self.storyboard?.//instantiateViewController(withIdentifier: "ViewController") as! ViewController
        //vc._groups = array
        self.navigationController?.pushViewController(vc, animated: true)
        
//        LadiesFilters().fetchOnlineList(page: 0) { (arrayLady) in
//            if let array = arrayLady{
//                let vc = ASVC()
//                //let vc = self.storyboard?.//instantiateViewController(withIdentifier: "ViewController") as! ViewController
//                vc._groups = array
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }

        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
