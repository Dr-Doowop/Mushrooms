//
//  KompassView.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 05.04.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit

class KompassView: UIView {
    var kompass: KompassLayer!
    var nadel: NadelLayer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initKompass()
    }
    func initKompass() {
        kompass = KompassLayer()
        var kompassRect = self.frame
        kompassRect.origin.x = 5.0
        kompassRect.origin.y = 5.0
        kompassRect.size.width -= 10.0
        kompassRect.size.height -= 10.0
        kompass.frame = kompassRect
        kompass.backgroundColor = UIColor.white.cgColor.copy(alpha: 0.5)
        kompass.setNeedsDisplay()
        
        nadel = NadelLayer()
        kompassRect.origin.x += 5.0
        kompassRect.origin.y += 5.0
        kompassRect.size.width -= 10.0
        kompassRect.size.height -= 10.0
        nadel.frame = kompassRect
//        nadel.backgroundColor = UIColor.brown.cgColor.copy(alpha: 0.5
//        )
        nadel.setNeedsDisplay()
        
        layer.addSublayer(kompass)
        layer.addSublayer(nadel)
    }
}
