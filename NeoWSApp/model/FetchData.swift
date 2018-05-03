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


class FetchData {
    
    func fetchData (url: String) {
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            if response.result.isSuccess {
                print("Got the info")
                let feedData : JSON = JSON(response.result.value!)
                Asteroid.test(json: feedData)
            } else {
                print("Error \(response.result.error)")
            }
        }
    }
    
//    func getWeatherData(url: String, parameters: [String: String]) {
//        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
//            response in
//            if response.result.isSuccess {
//                print("Success! Got the weather data")
//
//                let weatherJSON : JSON = JSON(response.result.value!)
//
//                self.updateWeatherData(json: weatherJSON)
//
//            } else {
//
//                self.cityLabel.text = "Connection Issues"
//            }
//        }
//    }
    
    func returnJSON (input: JSON) -> JSON {
        return input
    }
    
    
}
