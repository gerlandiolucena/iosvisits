//
//  AppDelegate.swift
//  iOSVisits
//
//  Created by Gerlandio da Silva Lucena on 5/17/16.
//  Copyright © 2016 ZAP Imóveis. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startMonitoringVisits()
        
        let notificationCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        notificationCategory.identifier = "INVITE_CATEGORY"
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:[.Sound, .Alert, .Badge], categories: nil))
        
        
        return true
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        NSUserDefaults.standardUserDefaults().setObject(deviceToken.description, forKey: "dispositivoID")
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

    func locationManager(manager: CLLocationManager, didVisit visit: CLVisit) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY hh:mm:ss"
        
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

