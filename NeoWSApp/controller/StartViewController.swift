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
//    let feedToday = "https://api.nasa.gov/neo/rest/v1/feed/today?detailed=true&api_key="
    let feed = "https://api.nasa.gov/neo/rest/v1/feed?start_date=2018-05-04&end_date=2018-05-04&api_key="
    
    
    //MARK: - Variables
    @IBOutlet weak var startTableView: UITableView!
    
    var listOfAsteroids = [Asteroid]()
    
    //MARK: - StartUp functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Test for FetchData Class
        
        let test = FetchData()
        test.fetchData(url: "\(feed)\(nasaKey)")
        
    }
    
    
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AsteroidBank.listOfAsteroids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CustomCell", owner: self, options: nil)?.first as! CustomCell
        
        let asteroid = AsteroidBank.listOfAsteroids[indexPath.row]
        
        cell.nameLabel.text = "Name: \(asteroid.name)"
        cell.distanceLabel.text = "Distance from Earth: \(asteroid.missDistance) km"
        cell.dangerousLabel.text = "Dangerous: \(asteroid.dangerous)"
        
        if asteroid.size > 999 {
            cell.sizeLabel.text =  String(format: "%.2f km", asteroid.size/1000)
        } else {
            cell.sizeLabel.text = String(format: "%.0f m", asteroid.size)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    //MARK: - MemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

