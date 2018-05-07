//
//  ViewController.swift
//  NeoWSApp
//
//  Created by a27 on 2018-05-03.
//  Copyright © 2018 a27. All rights reserved.
//

import UIKit
import SVProgressHUD

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables
    @IBOutlet weak var startTableView: UITableView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateViewHeight: NSLayoutConstraint!
    
    
    var listOfAsteroids = [Asteroid]()
    let todaysDate = GetAsteroidDate.todaysDate()
    
    //MARK: - StartUp functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: API Keys and API Url's
        
        let nasaKey = "mxYfugT2OQg976YfLCiansy1TbqxmdhdqGDb2P37"
        let feed = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(todaysDate)&end_date=\(todaysDate)&api_key="
        
        // MARK: Notification observer
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataStartTableView(notification:)), name: .doneParsing, object: nil)
        
        // MARK: Start download of feed
        
        let downloadFeed = FetchData()
        downloadFeed.fetchData(url: "\(feed)\(nasaKey)", date: todaysDate)
        
    }
    
    // MARK: - Notification
    
    @objc func reloadDataStartTableView(notification: NSNotification) {
        startTableView.reloadData()
        SVProgressHUD.dismiss()
    }
    
    //MARK: - Buttons
    @IBAction func searchBtnPressed(_ sender: UIBarButtonItem) {
        
        dateLabel.isHidden = true
        dateViewHeight.constant = 200
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    //MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if !AsteroidBank.listOfAsteroids.isEmpty {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
            tableView.rowHeight = 140
            tableView.isScrollEnabled = true
            
        } else {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No asteroid data available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            tableView.isScrollEnabled = false
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AsteroidBank.listOfAsteroids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CustomCell", owner: self, options: nil)?.first as! CustomCell
        
        let asteroid = AsteroidBank.listOfAsteroids[indexPath.row]
        
        cell.nameLabel.text = "\(asteroid.name)"
        if asteroid.size > 999 {
            cell.sizeLabel.text =  String(format: "%.2f km", asteroid.size/1000)
        } else {
            cell.sizeLabel.text = String(format: "%.0f m", asteroid.size)
        }
        cell.dangerousLabel.text = "\(asteroid.dangerous)"
        cell.velocityLabel.text = "\(asteroid.velocity) km/s"
        cell.distanceLabel.text = "\(asteroid.missDistance) km"
        cell.orbitingBodyLabel.text = "\(asteroid.orbitingBody)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
}

extension Notification.Name {
    static let doneParsing = Notification.Name("doneParsing")
}
