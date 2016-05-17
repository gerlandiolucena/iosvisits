//
//  LocationHelper.swift
//  iOSVisits
//
//  Created by Gerlandio da Silva Lucena on 5/17/16.
//  Copyright © 2016 ZAP Imóveis. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationHelper: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startMonitoringVisits()
    }
    
    func locationManager(manager: CLLocationManager, didVisit visit: CLVisit) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let message = "\(dateFormatter.stringFromDate(visit.arrivalDate)), \(visit.coordinate.latitude), \(visit.coordinate.longitude), \(visit.horizontalAccuracy)"
        let notification = UILocalNotification()
        notification.alertBody = "Você visitou o local \(message)"
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        //
    }
    
}
