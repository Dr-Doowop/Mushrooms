//
//  MeinePilzAnnotation.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 21.04.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit
import MapKit

class MeinePilzAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(withLocation coord: CLLocationCoordinate2D, title: String, subtitle: String){
        self.coordinate = coord
        self.title = title
        self.subtitle = subtitle
    }
}
