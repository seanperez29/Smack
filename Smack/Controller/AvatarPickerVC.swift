//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Sean Perez on 9/1/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var currentAvatarColor: AvatarColor = .dark
    enum AvatarColor {
        case dark, light
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        currentAvatarColor = currentAvatarColor == .dark ? .light : .dark
        collectionView.reloadData()
    }
    
}

extension AvatarPickerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.AvatarCell, for: indexPath) as! AvatarCell
        let imageName = currentAvatarColor == .dark ? "dark\(indexPath.row)" : "light\(indexPath.row)"
        cell.configureCell(imageName)
        return cell
    }
}

extension AvatarPickerVC: UICollectionViewDelegateFlowLayout {
    
}
