//
//  PlaceListViewController.swift
//  iOSVisits
//
//  Created by Gerlandio da Silva Lucena on 6/3/16.
//  Copyright © 2016 ZAP Imóveis. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class PlaceListViewController: UITableViewController {
    
    var places: Results<MyPlaces>?
    var arrayList = [MyPlaces]()
    
    override func viewDidLoad() {
        let realm = try! Realm()
        places = realm.objects(MyPlaces)
        arrayList = [MyPlaces]()
        if let places = places {
            for place in places {
                arrayList.append(place)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.contentInset = UIEdgeInsetsMake(40.0, 0.0, 0.0, 0.0)
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("default", forIndexPath: indexPath)
        if let defaultCell = cell as? Default {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd/MM/YYYY"
            let formatterTime = NSDateFormatter()
            formatterTime.dateFormat = "hh:mm:ss"
            defaultCell.title.text = formatter.stringFromDate(arrayList[0].chegada)
            defaultCell.arrived.text = "Chegada ás \(formatterTime.stringFromDate(arrayList[0].chegada))"
            defaultCell.departure.text = "Saída ás \(formatterTime.stringFromDate(arrayList[0].saida))"
            return defaultCell
        }
        return cell
    }

}
