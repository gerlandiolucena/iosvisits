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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startMonitoringVisits()
        
        let notificationCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        notificationCategory.identifier = "INVITE_CATEGORY"
        application.registerUserNotificationSettings(UIUserNotificationSettings(types:[.sound, .alert, .badge], categories: nil))
        addPlaces()
        
        return true
    }
    
    func addPlaces() {
        MyPlaces(value: ["latitude": -23.595708,
        "longitude": -46.684340,
        "chegada": Date(),
        "saida": Date()]).saveObject()
        
        MyPlaces(value: ["latitude": -23.596566,
        "longitude": -46.684570,
        "chegada": Date(),
        "saida": Date()]).saveObject()
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        UserDefaults.standard.set(deviceToken.description, forKey: "dispositivoID")
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        //A visita ainda não finalizou
        if visit.departureDate != Date.distantFuture {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YYYY hh:mm:ss"
            let message = "\(dateFormatter.string(from: visit.arrivalDate)), \(visit.coordinate.latitude), \(visit.coordinate.longitude), \(visit.horizontalAccuracy)"
            NotificationManager.showNotification("Local visitado!", message: message)
            MyPlaces(value: ["latitude": visit.coordinate.latitude,
            "longitude": visit.coordinate.longitude,
            "chegada": visit.arrivalDate,
            "saida": visit.departureDate]).saveObject()
        } else {
            NotificationManager.scheduleNotification("Você tem um motivo", message: "O Zap tem apartamentos, 2 quartos, 1 vaga na Vila Olímpia e muitos outros imóveis!", interval: 90, forPeriod: Period.Morning)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        //
    }


}

