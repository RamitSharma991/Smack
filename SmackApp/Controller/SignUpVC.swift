//
//  SignUpVC.swift
//  SmackApp
//
//  Created by Ramit sharma on 06/12/17.
//  Copyright © 2017 Ramit sharma. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
