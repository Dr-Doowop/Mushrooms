//
//  GiftigeSectionViewController.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 25.02.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit

class GiftigeSectionViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var giftigeCoverImageView: UIImageView!
    @IBOutlet weak var giftigeTitleLabel: UILabel!
    @IBOutlet weak var giftigeCaptionLabel: UILabel!
    @IBOutlet weak var giftigeBodyTextView: UITextView!
   
    @IBOutlet weak var giftigeProgressLabel: UILabel!
    
    
    // MARK: - variables
      
      var giftig: [String: String]!
      var giftige: [[String: String]]!
      var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giftigeTitleLabel.text = giftig["giftigtitle"]
                      giftigeCaptionLabel.text = giftig["giftigcaption"]
                      giftigeBodyTextView.text = giftig["giftigbody"]
                      giftigeCoverImageView.image = UIImage(named: giftig["giftigimage"]!)
                      giftigeProgressLabel.text = "\(indexPath.row+1) / \(giftige.count)"
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
