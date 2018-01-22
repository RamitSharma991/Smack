//
//  AddChannelVC.swift
//  SmackApp
//
//  Created by Ramit sharma on 17/01/18.
//  Copyright © 2018 Ramit sharma. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //Outlets
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var channelDescp: UITextField!
    @IBOutlet weak var BgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

    }

    @IBAction func closeModalPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createChannelBtn(_ sender: Any) {
        guard let channelName = nameTxt.text, nameTxt.text != "" else {return}
        guard let channelDesc = channelDescp.text else {return}
        SocketService.instance.addchannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func setUpView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        BgView.addGestureRecognizer(closeTouch)
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor : smakePlaceHolder])
        channelDescp.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor : smakePlaceHolder])
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
