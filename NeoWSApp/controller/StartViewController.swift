//
//  ViewController.swift
//  NeoWSApp
//
//  Created by a27 on 2018-05-03.
//  Copyright © 2018 a27. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables
    @IBOutlet weak var startTableView: UITableView!
    
    var listOfAsteroids = [Asteroid]()
    
    //MARK: - StartUp functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add test data to list
        listOfAsteroids.append(Asteroid(name: "Asteroid nr 555", distance: 230, size: 15, isDangerous: true))
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
        cell.dangerousLabel.text = "Asteroid is dangerous: \(asteroid.isDangerous)"
        cell.sizeLabel.text = "Diameter: \(asteroid.size) m"
        
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

