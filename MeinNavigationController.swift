//
//  MeinNavigationController.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 19.04.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit

class MeinNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        // Do any additional setup after loading the view.
    }
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        print("navi gedreht")
        return UIInterfaceOrientationMask.portrait
    }

}
