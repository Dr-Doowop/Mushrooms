//
//  GiftigePilzeViewController.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 25.02.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit

class GiftigePilzeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var giftigeScrollView: UIScrollView!
    
    @IBOutlet weak var giftigeCollectionView: UICollectionView!
    
    @IBOutlet weak var giftigeView: UIView!
    
    
    // MARK: - Variables
//    var isStatusBarHidden = false
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBar
//          navigationController?.setNavigationBarHidden(false, animated: false)
       // MARK: - Delegates
        
             // collectionView Delegate
             giftigeCollectionView.delegate = self
             giftigeCollectionView.dataSource = self
    }
        // StatusBar
        func setStatusBarBackgroundColor(color: UIColor) {
            guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
            statusBar.backgroundColor = color
        }
        // StatusBar
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        // MARK: - Segue
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ToGiftigeSection" {
                let toViewController = segue.destination as! GiftigeSectionViewController
                let indexPath = sender as! IndexPath
                let giftig =  giftige[indexPath.row]
                toViewController.giftig = giftig
                toViewController.giftige = giftige
                toViewController.indexPath = indexPath
                
                // StatusBar
//                isStatusBarHidden = false
 //               UIView.animate(withDuration: 0.5, animations: {
  //                             self.setNeedsStatusBarAppearanceUpdate()
//                               })
            }
        }
    // MARK: - viewWillAppear
//     override func viewWillAppear(_ animated: Bool) {
 //        super.viewDidAppear(false)
//         isStatusBarHidden = true
 //        UIView.animate(withDuration: 0.5) {
 //            self.setNeedsStatusBarAppearanceUpdate()
         }
 //    }
     // Statusbar
//     override var prefersStatusBarHidden: Bool {
//         return isStatusBarHidden
 //    }
     // Statusbar Animation
//     override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
 //        return .slide
 //    }
//}
// MARK: - Extensions


// MARK: - CollectionView

extension GiftigePilzeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftige.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "giftigeCell", for: indexPath) as! GiftigeCollectionViewCell
        let giftig = giftige[indexPath.row]
        cell.giftigeTitleLabel.text = giftig["giftigtitle"]
        cell.giftigeCaptionLabel.text = giftig["giftigcaption"]
        cell.giftigeCoverImageView.image = UIImage(named: giftig["giftigimage"]!)
        
        cell.layer.transform = animateCell(cellFrame: cell.frame)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "ToGiftigeSection", sender: indexPath)
    }
}
////////////////////////////////////////////////////////////////
//MARK:-
//MARK:- Paralax Effect
//MARK:-
////////////////////////////////////////////////////////////////

// Paralax Effect for scrollView
extension GiftigePilzeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        // Navigationbar
 //       let navigationIsHidden = offsetY <= 0
//      navigationController?.setNavigationBarHidden(navigationIsHidden, animated: true)
        
        if offsetY < 0 {
            giftigeView.transform = CGAffineTransform(translationX: 0, y: offsetY)
             giftigeCollectionView.transform = CGAffineTransform(translationX: 0, y: -offsetY/2)
        }
        
        // Paralax Effect for collectionView
        if let collectionView = scrollView as? UICollectionView {
            for cell in collectionView.visibleCells as! [GiftigeCollectionViewCell] {
                let indexPath = collectionView.indexPath(for: cell)!
                let attributes = collectionView.layoutAttributesForItem(at: indexPath)!
                let cellFrame = collectionView.convert(attributes.frame, to: view)
                
                let translationX = cellFrame.origin.x / 5
                cell.giftigeCoverImageView.transform = CGAffineTransform(translationX: translationX, y: 0)
                
                cell.layer.transform = animateCell(cellFrame: cellFrame)
            }
        }
    }
    func animateCell(cellFrame: CGRect) -> CATransform3D {
        let angleFromX = Double((-cellFrame.origin.x) / 10)
        let angle = CGFloat((angleFromX * Double.pi) / 100.0)
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        let rotation = CATransform3DRotate(transform, angle, 0, 1, 0)
        
        var scaleFromX = (1000 - (cellFrame.origin.x - 200)) / 1000
        let scaleMax: CGFloat = 0.8
        let scaleMin: CGFloat = 0.6
        if scaleFromX > scaleMax {
            scaleFromX = scaleMax
        }
        if scaleFromX < scaleMin {
            scaleFromX = scaleMin
        }
        let scale = CATransform3DScale(CATransform3DIdentity, scaleFromX, scaleFromX, 1)
        
        return CATransform3DConcat(rotation, scale)
    }
}
