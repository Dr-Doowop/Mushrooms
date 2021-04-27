//
//  ViewController.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 23.02.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit

class PilzeHomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mainPilzView: UIView!
    @IBOutlet weak var cookBookView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pilzGuideCollectionView: UICollectionView!
    
    @IBOutlet weak var pilzBackGroundImageView: UIImageView!
    @IBOutlet weak var cookBookImageView: UIImageView!
    
    @IBOutlet weak var pilzeTitleLabel: UILabel!
    
    
    // MARK: - Variables
    var isStatusBarHidden = false
    // MARK: - Actions
        

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // NavigationBar
        navigationController?.setNavigationBarHidden(true, animated: false)
       
       
       // MARK: - Delegates
       
       // scrollView Delegate
       scrollView.delegate = self
       
       // collectionView Delegate
       pilzGuideCollectionView.delegate = self
       pilzGuideCollectionView.dataSource = self
        
        // MARK: - Animation
        
        // Fades in Icons at Appstart
        pilzeTitleLabel.alpha = 0
        cookBookImageView.alpha = 0
      
        
        UIView.animate(withDuration: 1) {
            self.pilzeTitleLabel.alpha = 1
            self.cookBookImageView.alpha = 1
        }
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
        if segue.identifier == "HometoPilzGuide" {
            let toViewController = segue.destination as! PilzguideViewController
            let indexPath = sender as! IndexPath
            let section = sections[indexPath.row]
            toViewController.section = section
            toViewController.sections = sections
            toViewController.indexPath = indexPath
            // StatusBar
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.5, animations: {
                           self.setNeedsStatusBarAppearanceUpdate()
                           })
        }
    }
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        isStatusBarHidden = false
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    // Statusbar
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    // Statusbar Animation
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}
// MARK: - Extensions

////////////////////////////////////////////////////////////////
//MARK:-
//MARK:- CollectionView
//MARK:-
////////////////////////////////////////////////////////////////

extension PilzeHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "essbarePilzeCell", for: indexPath) as! PilzguideCollectionViewCell
        let section = sections[indexPath.row]
        cell.titleLabel.text = section["title"]
        cell.captionLabel.text = section["caption"]
        cell.coverImageView.image = UIImage(named: section["image"]!)
        
        cell.layer.transform = animateCell(cellFrame: cell.frame)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "HometoPilzGuide", sender: indexPath)
    }
}

////////////////////////////////////////////////////////////////
//MARK:-
//MARK:- Paralax Effect
//MARK:-
////////////////////////////////////////////////////////////////

// Paralax Effect for scrollView
extension PilzeHomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        // Navigationbar
        let navigationIsHidden = offsetY <= 0
        navigationController?.setNavigationBarHidden(navigationIsHidden, animated: true)
        
        if offsetY < 0 {
            mainPilzView.transform = CGAffineTransform(translationX: 0, y: offsetY)
             pilzBackGroundImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/2)
            cookBookImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/3)
        }
        
        // Paralax Effect for collectionView
        if let collectionView = scrollView as? UICollectionView {
            for cell in collectionView.visibleCells as! [PilzguideCollectionViewCell] {
                let indexPath = collectionView.indexPath(for: cell)!
                let attributes = collectionView.layoutAttributesForItem(at: indexPath)!
                let cellFrame = collectionView.convert(attributes.frame, to: view)
                
                let translationX = cellFrame.origin.x / 5
                cell.coverImageView.transform = CGAffineTransform(translationX: translationX, y: 0)
                
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

    




