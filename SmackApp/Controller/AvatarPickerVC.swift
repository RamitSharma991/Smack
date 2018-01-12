//
//  AvatarPickerVC.swift
//  SmackApp
//
//  Created by Ramit sharma on 04/01/18.
//  Copyright © 2018 Ramit sharma. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

//Variables
    var avatarType = AvatarType.dark
    

//Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//setters for the protocols
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
        return cell
        }
        return AvatarCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numOfColumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numOfColumns = 4
        }
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarNamae(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarNamae(avatarName: "light\(indexPath.item)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    @IBAction func segmentControlChange(_ sender: Any) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            avatarType == .dark
        }
        else {
            avatarType == .light
        }
        collectionView.reloadData()
    }
    
}
