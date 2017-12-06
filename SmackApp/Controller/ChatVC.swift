//
//  ChatVC.swift
//  SmackApp
//
//  Created by Ramit sharma on 01/12/17.
//  Copyright © 2017 Ramit sharma. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //Outlets
    @IBOutlet weak var menuButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
//Code for Sliding View after tapping menuButton
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
//Code to Slide back the view after we drag it or swipe it
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

    }


}
