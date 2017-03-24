//
//  NotificationManager.swift
//  iOSVisits
//
//  Created by Gerlandio da Silva Lucena on 6/3/16.
//  Copyright © 2016 ZAP Imóveis. All rights reserved.
//

import UIKit
import Foundation

enum Period: String {
    case Morning = "Morning",
    Late = "Late",
    Afternoon = "Afternoon"
}

class NotificationManager {

    class func showNotification(_ title: String, message: String){
        let notification = UILocalNotification()
        notification.alertTitle = title
        notification.alertBody = message
        UIApplication.shared.presentLocalNotificationNow(notification)
    }
    
    class func scheduleNotification(_ title: String, message: String, interval: Int, forPeriod: Period){
        if wasFired(forPeriod) {
            let notification = UILocalNotification()
            notification.alertTitle = title
            notification.alertBody = message
            notification.fireDate = Date(timeIntervalSinceNow: TimeInterval(interval))
            UIApplication.shared.scheduleLocalNotification(notification)
            UserDefaults.standard.set(Date(), forKey: forPeriod.rawValue)
        }
    }
    
    class func wasFired(_ forPeriod: Period) -> Bool {
        if let firedDateObj = UserDefaults.standard.object(forKey: forPeriod.rawValue) as? Date {
            let formatedDate = DateFormatter()
            formatedDate.dateFormat = "yyyy/MM/dd 00:00:00"
            
            if let currentDate = formatedDate.date(from: formatedDate.string(from: Date())) {
                if let firedDate = formatedDate.date(from: formatedDate.string(from: firedDateObj)) {
                    return (currentDate.compare(firedDate) == .orderedAscending)
                }
            }
        }
        
        return false
    }
}
