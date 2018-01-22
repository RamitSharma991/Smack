//
//  MessageCell.swift
//  SmackApp
//
//  Created by Ramit sharma on 19/01/18.
//  Copyright © 2018 Ramit sharma. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    //outlets
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(message: Message) {
        messageBodyLabel.text = message.message
        userLabel.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnColor(components: message.userAvatarColor)
        guard var isoDate = message.timeStamp else {return}
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("z"))
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDat {
        let finalDate = newFormatter.string(from: finalDate)
            timeStampLabel.text = finalDate
        }
    }

}
