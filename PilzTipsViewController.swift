//
//  PilzTipsViewController.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 24.02.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit

class PilzTipsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pilzTipsCollectionView: UICollectionView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

    // MARK: - Delegates
        // Delegates
              pilzTipsCollectionView.delegate = self
              pilzTipsCollectionView.dataSource = self
    }
}

// MARK: - Extensions

extension PilzTipsViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pilzeTipsCell", for: indexPath) as! PilzTipsCollectionViewCell
        let tip = tips[indexPath.row]
        cell.textLabel.text = tip["text"]
        cell.tipNameLabel.text = tip["tipname"]
        cell.tipDescriptionLabel.text = tip["tipdescription"]
        cell.avatarImageView.image = UIImage(named: tip["avatar"]!)
        
        return cell
    }
}
