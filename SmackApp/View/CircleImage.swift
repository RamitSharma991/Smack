//
//  CircleImage.swift
//  SmackApp
//
//  Created by Ramit sharma on 11/01/18.
//  Copyright © 2018 Ramit sharma. All rights reserved.
//

import UIKit


@IBDesignable
class CircleImage: UIImageView {
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
