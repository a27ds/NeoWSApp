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
        checkIfInternetAlert(type: "data")
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
        checkIfInternetAlert(type: "image")
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
    
    // MARK: - Check if Internet is avalible
    
    func checkIfInternetAlert(type: String) {
        if isConnectedToInternet() {
            print("You have the Internetz!")
            SVProgressHUD.show(withStatus: "Downloading \(type)")
        } else {
            print("Pity the fool!")
//            errorMessageInTableView = "You don't have any Internet Connection"
//            SVProgressHUD.dismiss()
                        SVProgressHUD.setMaximumDismissTimeInterval(7)
                        SVProgressHUD.showError(withStatus: "Pity the fool! You don't have any Internetz Connection")
                        SVProgressHUD.setMaximumDismissTimeInterval(1)
        }
    }
    
    // MARK: - Helpers
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    
    
}
