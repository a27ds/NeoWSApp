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
                JSONParsing.parsing(json: feedData)
            } else {
                print("Error \(response.result.error)")
            }
        }
    }
}
