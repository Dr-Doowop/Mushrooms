//
//  KompassViewController.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 04.04.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit
import CoreMotion

class KompassViewController: UIViewController {
    
    var myMotionManager: CMMotionManager!
 
    @IBOutlet weak var myKompass: KompassView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        myMotionManager = myAppDelegate.sharedMotionManager()
    }
 
    @IBAction func safariButton_Tapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "More at the Web", sender: "https://www.pilzfinder.de/pilze.html")
    }
    @IBAction func emailButton_Tapped(_ sender: UIBarButtonItem) {
        let email = "rene.walliczek@googlemail.com"
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
            }
    }
    @IBAction func infoButton_Tapped(_ sender: UIBarButtonItem) {
          performSegue(withIdentifier: "More at the Web", sender: "https://de.wikipedia.org/wiki/Pilze")
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

          if let identifier = segue.identifier, identifier == "More at the Web" {
              let toNav = segue.destination as! UINavigationController
              let toVC = toNav.viewControllers.first as! WebViewController
            toVC.urlString = (sender as! String)
          }
      }
    func updateDeviceMotion(motion: CMDeviceMotion){
         let attitude = motion.attitude
         let yaw: CGFloat = CGFloat(attitude.yaw)
         var transform: CATransform3D = CATransform3DIdentity
         transform = CATransform3DRotate(transform, yaw, 0.0, 0.0, 1.0)
         self.myKompass.nadel.transform = transform
     }
    override func viewWillAppear(_ animated: Bool) {
        myMotionManager.deviceMotionUpdateInterval = 0.1
        myMotionManager!.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xMagneticNorthZVertical, to: .main, withHandler: {
            (deviceMotion, error) in
            if error != nil{
                print("Magnetic-Error")
                return
            }else{
                self.updateDeviceMotion(motion: deviceMotion!)
            }
        })
    }
}
