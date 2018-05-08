//
//  JSONParsing.swift
//  NeoWSApp
//
//  Created by a27 on 2018-05-04.
//  Copyright © 2018 a27. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONParsing {
    static func parsing(json: JSON, date: String) {
        for result in json["near_earth_objects"][date].arrayValue{
            let name = result["name"].stringValue
            let size = result["estimated_diameter"]["meters"]["estimated_diameter_max"].floatValue
            let dangerous = result["is_potentially_hazardous_asteroid"].boolValue
            let velocity = result["close_approach_data"][0]["relative_velocity"]["kilometers_per_second"].intValue
            let missDistance = result["close_approach_data"][0]["miss_distance"]["kilometers"].intValue
            let orbitingBody = result["close_approach_data"][0]["orbiting_body"].stringValue
            let asteroid = Asteroid(name: name, size: size, dangerous: dangerous, velocity: velocity, missDistance: missDistance, orbitingBody: orbitingBody)
            AsteroidBank.listOfAsteroids.append(asteroid)
            
        }
        NotificationCenter.default.post(name: .doneParsing, object: nil)
    }
    
    static func parsingPOD(json: JSON) {
        let url = json["url"].stringValue
        
        PODImage.imageUrl = url
        
        NotificationCenter.default.post(name: .doneParsingImageURL, object: nil)
        
    }
    
   
}

