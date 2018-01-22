//
//  ChatVC.swift
//  SmackApp
//
//  Created by Ramit sharma on 01/12/17.
//  Copyright © 2017 Ramit sharma. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var typingUsersConnect: UILabel!
    
    //Variables
    var isTyping = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
// Automatic increases message row widgth
        sendButton.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
// hides the keyboard+elevated textField post typing
        
        
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
//Code for Sliding View after tapping menuButton

        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
//Code to Slide back the view after we drag it or swipe it

    
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidCHange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
            
        }
      
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            var names = ""
            // holds the names of people typing
            
            var numberOfTypers = 0
            
            for (typingUsers, channel) in typingUsers {
                if typingUsers != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUsers
                    } else {
                        names = "\(names), \(typingUsers)"
                    }
                    numberOfTypers += 1
                }
                if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                    
                    var verb = "is"
                    
                    if numberOfTypers > 1 {
                        verb = "are"
                    }
                    
                    self.typingUsersConnect.text = "\(names) \(verb) typing a message"
                } else {
                    
                    self.typingUsersConnect.text = ""
                    // if nobody's typing
                }
            }
            
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
    }
    @objc func userDataDidCHange(_ notif: Notification) {
        
        if AuthService.instance.isLoggedIn{
            //get channels
            onLoginMessages()
            
        } else {
            channelNameLabel.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
        
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLabel.text = "\(channelName)"
        getMessages()
    }
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id
            else {return}
        if messageTextField.text  == "" {
            isTyping = false
            sendButton.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            if isTyping == false
            {
            sendButton.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true
        }
        
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id
                else {return}
            guard let message = messageTextField.text
                    else {return}
            SocketService.instance.addMessages(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
                }
            })
        }
        
    }
    func onLoginMessages() {
        MessageService.instance.findAllChannels { (success) in
            if success {
                //do stuff with channels
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No channels yet"
                }
            }
        }
        
    }
    
    func getMessages() {
        
        guard let channelID = MessageService.instance.selectedChannel?.id
            else {return}
        MessageService.instance.findAllMessagesForChannel(channelId: channelID) { (success) in
            if success {
                self.tableView.reloadData()
            }
            
        }}
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)-> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MessageService.instance.messages.count
    }
    
}

    


