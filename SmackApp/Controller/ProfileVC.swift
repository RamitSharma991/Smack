//
//  ProfileVC.swift
//  SmackApp
//
//  Created by Ramit sharma on 16/01/18.
//  Copyright © 2018 Ramit sharma. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
//Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    @IBAction func closeModalBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setUpView() {
        userName.text = UserDataService.instance.name
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        emailLabel.text = UserDataService.instance.Email
        profileImage.backgroundColor = UserDataService.instance.returnColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: closeTap(_recognizer: #selector(ProfileVC.closeTap(_:))))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap (_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

