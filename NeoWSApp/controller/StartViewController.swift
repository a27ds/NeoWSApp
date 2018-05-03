//
//  ViewController.swift
//  NeoWSApp
//
//  Created by a27 on 2018-05-03.
//  Copyright © 2018 a27. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - API Keys and API Url's
    
    let nasaKey = "mxYfugT2OQg976YfLCiansy1TbqxmdhdqGDb2P37"
    let feedToday = "https://api.nasa.gov/neo/rest/v1/feed/today?detailed=true&api_key="
    
    //MARK: - Variables
    @IBOutlet weak var startTableView: UITableView!
    
    var listOfAsteroids = [Asteroid]()
    
    //MARK: - StartUp functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Test for FetchData Class
        
        let test = FetchData()
        test.today(url: "\(feedToday)\(nasaKey)")
        
        //Add test data to list
        listOfAsteroids.append(Asteroid(name: "Asteroid nr 555", distance: 230, size: 15, isDangerous: true))
        listOfAsteroids.append(Asteroid(name: "7788A", distance: 34568, size: 57483, isDangerous: false))
    }
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfAsteroids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CustomCell", owner: self, options: nil)?.first as! CustomCell
        
        let asteroid = listOfAsteroids[indexPath.row]
        
        cell.nameLabel.text = "Name: \(asteroid.name)"
        cell.distanceLabel.text = "Distance from Earth: \(asteroid.distance) km"
        cell.dangerousLabel.text = "Dangerous: \(asteroid.isDangerous)"
        
        if asteroid.size > 999 {
            cell.sizeLabel.text =  String(format: "Diameter: %.2f km", asteroid.size/1000)
        } else {
            cell.sizeLabel.text = String(format: "Diameter: %.0f m", asteroid.size)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    //MARK: - MemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

