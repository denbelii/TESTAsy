//
//  LoginVC.swift
//  ASCollectiTEST
//
//  Created by Nataliia Klemenchenko on 02/04/2017.
//  Copyright © 2017 Andrew Klemenchenko. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var activityIndicLoadList: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFieldDelegate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicLoadList.isHidden = true
        loginText.text = "alex572481@gmail.com"
        passwordText.text = "alex572481"
        emailTextField.delegate = self
        passwordText.delegate = self
        //hideKeyBoardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginRequest(_ sender: Any) {
        activityIndicLoadList.startAnimating()
        if loginText != nil && passwordText != nil && loginText.text != "" && passwordText.text != "" {
            goListLady()
        }else{
            print("Введите логин или пароль")
        }
    }
    
    func goListLady(){
        let listLady = self.storyboard?.instantiateViewController(withIdentifier: "ListLadyVC") as! ListLadyVC
        self.navigationController?.pushViewController(listLady, animated: true)
        activityIndicLoadList.stopAnimating()
    }
    
    func login(complation: @escaping () -> ()){
        activityIndicLoadList.isHidden = false
        BOFLogin(userName: self.loginText.text!, password: self.passwordText.text!).fetchTokenKey { (tokenKey) in
            if let tokenKey = tokenKey{
                KeyChain.setToken(tokenKey: tokenKey)
                complation(self.goListLady())
            }
        }
    }
}

extension LoginVC: UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
