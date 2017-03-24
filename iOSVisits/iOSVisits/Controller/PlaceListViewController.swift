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
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.contentInset = UIEdgeInsetsMake(40.0, 0.0, 0.0, 0.0)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        if let defaultCell = cell as? Default {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/YYYY"
            let formatterTime = DateFormatter()
            formatterTime.dateFormat = "hh:mm:ss"
            defaultCell.title.text = formatter.string(from: arrayList[0].chegada as Date)
            defaultCell.arrived.text = "Chegada ás \(formatterTime.string(from: arrayList[0].chegada as Date))"
            defaultCell.departure.text = "Saída ás \(formatterTime.string(from: arrayList[0].saida as Date))"
            return defaultCell
        }
        return cell
    }

}
