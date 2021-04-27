//
//  tabBarViewController.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 09.04.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//
import Foundation
import UIKit

class tabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
          delegate = self
        // Do any additional setup after loading the view.
    }
}
   

  extension tabBarViewController: UITabBarControllerDelegate  {
    @objc func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.6 , options: [.transitionCrossDissolve], completion: { (true) in
            })
            self.selectedViewController = viewController
        }
        return true
    }
}
