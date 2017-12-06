//
//  LoginVC.swift
//  SmackApp
//
//  Created by Ramit sharma on 06/12/17.
//  Copyright © 2017 Ramit sharma. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func toCreateAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCreateAccount", sender: nil)
    }
    
}
