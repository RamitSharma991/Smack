//
//  ChannelVC.swift
//  SmackApp
//
//  Created by Ramit sharma on 01/12/17.
//  Copyright © 2017 Ramit sharma. All rights reserved.
//

import UIKit

@IBDesignable
class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var tableView: UITableView!

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        self.revealViewController().rearViewRevealWidth = (self.view.frame.width - 60)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidCHange(_:)) , name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelIsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.tableView.reloadData()
                //mesages from other channels
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo()
    }

    @IBAction func addChannelPressed(_ sender: Any) {
        
        //only AddChannel If we are already looged in
        if AuthService.instance.isLoggedIn {
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            //Show Profile Page
            let profile = ChannelVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
            
        }
        
        
    }
    @objc func userDataDidCHange(_ notif: Notification) {
        setUpUserInfo()
    }
    
    @objc func channelIsLoaded(_ notif: Notification) {
        tableView.reloadData()
    }
    
    func setUpUserInfo() {
        
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnColor(components: UserDataService.instance.avatarColor)
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            tableView.reloadData()
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? channelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
            
        }    else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        if MessageService.instance.unreadChannels.count > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel.id}
        }
        let index = IndexPath(row: indexPath.row, section: 0)
        tableView.reloadRows(at: [index], with: .none)
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController().revealToggle(animated: true)
    }
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
}
