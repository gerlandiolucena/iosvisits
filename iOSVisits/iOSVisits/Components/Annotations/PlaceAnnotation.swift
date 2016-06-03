//
//  PlaceAnnotation.swift
//  iOSVisits
//
//  Created by Gerlandio da Silva Lucena on 6/3/16.
//  Copyright © 2016 ZAP Imóveis. All rights reserved.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    
    @objc var title: String?
    @objc var coordinate: CLLocationCoordinate2D
    
    init(title: String, coord: CLLocationCoordinate2D) {
        self.title = title
        coordinate = coord
    }
}
