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

    class func showNotification(title: String, message: String){
        let notification = UILocalNotification()
        notification.alertTitle = title
        notification.alertBody = message
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    class func scheduleNotification(title: String, message: String, interval: Int, forPeriod: Period){
        if wasFired(forPeriod) {
            let notification = UILocalNotification()
            notification.alertTitle = title
            notification.alertBody = message
            notification.fireDate = NSDate(timeIntervalSinceNow: NSTimeInterval(interval))
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: forPeriod.rawValue)
        }
    }
    
    class func wasFired(forPeriod: Period) -> Bool {
        if let firedDateObj = NSUserDefaults.standardUserDefaults().objectForKey(forPeriod.rawValue) as? NSDate {
            let formatedDate = NSDateFormatter()
            formatedDate.dateFormat = "yyyy/MM/dd 00:00:00"
            
            if let currentDate = formatedDate.dateFromString(formatedDate.stringFromDate(NSDate())) {
                if let firedDate = formatedDate.dateFromString(formatedDate.stringFromDate(firedDateObj)) {
                    return (currentDate.compare(firedDate) == .OrderedAscending)
                }
            }
        }
        
        return false
    }
}
