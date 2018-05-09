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
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var listOfAsteroids = [Asteroid]()
    var asteroidDate = GetAsteroidDate.todaysDate()
    var pick : UIDatePicker!
    var searchBarButton : UIBarButtonItem!
    let downloadFeed = FetchData()

    
    //MARK: - StartUp functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Notification observer
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataStartTableView(notification:)), name: .doneParsing, object: nil)
        
        // MARK: Start download of feed
        
        downloadFeed.fetchData(date: asteroidDate)
        
        // MARK: - Set datepicker
        
        pick = datePicker()
        pick.alpha = 0
        searchBarButton = searchButton
    }
    
    // MARK: - Notification
    
    @objc func reloadDataStartTableView(notification: NSNotification) {
        dateLabel.text = asteroidDate
        startTableView.reloadData()
        SVProgressHUD.dismiss()
    }
    
    //MARK: - Buttons
    @IBAction func searchBtnPressed(_ sender: UIBarButtonItem) {
        
        dateViewHeight.constant = 150
        
        dateView.addSubview(pick)
        pick.frame.size.width = self.view.bounds.width
        pick.frame.size.height = 0
        
        UIView.animate(withDuration: 0.3) {
            self.pick.alpha = 1
            self.dateLabel.alpha = 0
            self.pick.frame.size.height = 150
            self.view.layoutIfNeeded()
        }
        
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector( hideDatePicker(sender:) ) )
        navBar.rightBarButtonItem = doneBarButton
        navBar.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func hideDatePicker(sender: UIBarButtonItem) {
        pick.removeFromSuperview()
        downloadFeed.fetchData(date: getDateFromDatePicker())
    
        UIView.animate(withDuration: 0.3) {
            self.dateLabel.alpha = 1
            self.pick.alpha = 0
            self.dateViewHeight.constant = 60
            self.view.layoutIfNeeded()
        }
        navBar.rightBarButtonItem = searchButton
    }
    
    func getDateFromDatePicker() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: self.pick.date)
        dateFormatter.dateFormat = "MM"
        let month: String = dateFormatter.string(from: self.pick.date)
        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from: self.pick.date)
        let dateFromDatePicker = "\(year)-\(month)-\(day)"
        asteroidDate = dateFromDatePicker
        return dateFromDatePicker
        
        
    }
    
    // MARK: - PickerWheel
    
    func datePicker() -> UIDatePicker {
        let timePicker = UIDatePicker()
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        formatter.timeStyle = DateFormatter.Style.none
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.dateFormat = "yyyy-MM-dd"
        timePicker.datePickerMode = UIDatePickerMode.date
        timePicker.locale = Locale(identifier: "sv_SE")
        timePicker.setValue(UIColor.white, forKey: "textColor")
        return timePicker
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
    static let doneParsingImageURL = Notification.Name("doneParsingImageURL")
}
