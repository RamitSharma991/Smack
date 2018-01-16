//
//  LoginVC.swift
//  SmackApp
//
//  Created by Ramit sharma on 06/12/17.
//  Copyright © 2017 Ramit sharma. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //Outlets
    
    @IBOutlet weak var usrnmTxt: UITextField!
    
    @IBOutlet weak var pswdTxt: UITextField!
    
    @IBOutlet weak var spinner2: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpview()

        // Do any additional setup after loading the view.
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func toCreateAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCreateAccount", sender: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        spinner2.isHidden = false
        spinner2.startAnimating()
        
        guard let email = usrnmTxt.text, usrnmTxt.text != "" else {
            return
        }
        guard let pass = pswdTxt.text, pswdTxt.text != "" else {
            return
        }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner2.isHidden = true
                        self.spinner2.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func setUpview() {
        
        spinner2.isHidden = true
        usrnmTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smakePlaceHolder])
        pswdTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smakePlaceHolder])
       
    }
}
