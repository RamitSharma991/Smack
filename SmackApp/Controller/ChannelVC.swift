//
//  ChannelVC.swift
//  SmackApp
//
//  Created by Ramit sharma on 01/12/17.
//  Copyright © 2017 Ramit sharma. All rights reserved.
//

import UIKit

@IBDesignable
class ChannelVC: UIViewController {
    
//Outlets
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var userImg: CircleImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = (self.view.frame.width - 60)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidCHange(_:)) , name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    @objc func userDataDidCHange(_ notif: Notification) {
        
        if AuthService.instance.isLooggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnColor(components: UserDataService.instance.avatarColor)
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            
        }
        
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
}
