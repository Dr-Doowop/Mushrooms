//
//  PilzguideViewController.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 24.02.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit

class PilzguideViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var bodyLabel: UITextView!
    
    
    // MARK: - variables
      
      var section: [String: String]!
      var sections: [[String: String]]!
      var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = section["title"]
               captionLabel.text = section["caption"]
               bodyLabel.text = section["body"]
               coverImageView.image = UIImage(named: section["image"]!)
               progressLabel.text = "\(indexPath.row+1) / \(sections.count)"
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    
}
