//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Sean Perez on 9/1/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

enum AvatarColor {
    case dark, light
}

class AvatarPickerVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var currentAvatarColor: AvatarColor = .dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        currentAvatarColor = segmentedControl.selectedSegmentIndex == 0 ? .dark : .light
        collectionView.reloadData()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AvatarPickerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.AvatarCell, for: indexPath) as! AvatarCell
        cell.configureCell(forAvatarColor: currentAvatarColor, atIndex: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = UIScreen.main.bounds.width > 320 ? 4 : 3
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColumns - 1) * spaceBetweenCells) / numberOfColumns
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentAvatarColor == .dark {
            UserDataService.instance.updateAvatarName("dark\(indexPath.item)")
        } else {
            UserDataService.instance.updateAvatarName("light\(indexPath.item)")
        }
        dismiss(animated: true, completion: nil)
    }
}

extension AvatarPickerVC: UICollectionViewDelegateFlowLayout {
    
}
