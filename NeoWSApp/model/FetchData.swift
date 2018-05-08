//
//  fetchData.swift
//  NeoWSApp
//
//  Created by Erik Hede on 2018-05-03.
//  Copyright © 2018 a27. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

class FetchData {
    
    func fetchData (date: String) {
        let nasaKey = "mxYfugT2OQg976YfLCiansy1TbqxmdhdqGDb2P37"
        let feed = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(date)&end_date=\(date)&api_key="
        let url = "\(feed)\(nasaKey)"
        AsteroidBank.listOfAsteroids.removeAll()
        SVProgressHUD.show(withStatus: "Downloading data")
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            if response.result.isSuccess {
                print("Got the info")
                let feedData : JSON = JSON(response.result.value!)
                JSONParsing.parsing(json: feedData, date: date)
            } else {
                print("Error \(response.result.error)")
            }
        }
    }
    
    func fetchDataImage (url: String) {
        SVProgressHUD.show(withStatus: "Downloading image")
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            if response.result.isSuccess {
                print("Got the image info")
                let feedData : JSON = JSON(response.result.value!)
                JSONParsing.parsingPOD(json: feedData)
            } else {
                print("Error \(response.result.error)")
            }
        }
    }
    
    
    
}
