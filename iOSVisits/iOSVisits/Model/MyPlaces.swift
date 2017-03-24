//
//  MyPlaces.swift
//  iOSVisits
//
//  Created by Gerlandio da Silva Lucena on 6/3/16.
//  Copyright © 2016 ZAP Imóveis. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift

class MyPlaces: Object {

    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var chegada: Date = Date()
    dynamic var saida: Date =  Date()
    dynamic var Nome: String?
    
    func saveObject(){
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
}
