//
//  ViewController.swift
//  iOSVisits
//
//  Created by Gerlandio da Silva Lucena on 5/17/16.
//  Copyright © 2016 ZAP Imóveis. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var places: Results<MyPlaces>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm()
        places = realm.objects(MyPlaces)
        loadAnnotations()
    }
    
    func loadAnnotations() {
        guard let places = places else {
            return
        }
        
        for place in places {
            let annotation = PlaceAnnotation(
                title: "",
                coord: CLLocationCoordinate2D(
                    latitude: place.latitude,
                    longitude: place.longitude))
            mapView.addAnnotation(annotation)
        }
        let coordinate = CLLocationCoordinate2D(latitude: places[0].latitude, longitude: places[0].longitude)
        
        mapView.setRegion(mapView.regionThatFits(MKCoordinateRegionMakeWithDistance(coordinate, 500, 500)), animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

