//
//  Asteroid.swift
//  NeoWSApp
//
//  Created by Erik Hede on 2018-05-03.
//  Copyright © 2018 a27. All rights reserved.
//

import Foundation
import SwiftyJSON

class Asteroid {
    var name : String
    var distance : Int
    var size : Float
    var isDangerous : Bool
    
    init(name: String, distance: Int, size: Float, isDangerous: Bool) {
        self.name = name
        self.distance = distance
        self.size = size
        self.isDangerous = isDangerous
    }
    
    static func test(json: JSON) {
        print(json)
        // Här får vi parsa in JSON alternativ att vi skapar en ny klass som man tar in JSON och parsar ut allt
    }
}
