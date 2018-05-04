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
    var size : Float
    var dangerous : Bool
    var velocity : Int
    var missDistance : Int
    var orbitingBody : String

    init(name: String, size: Float, dangerous: Bool, velocity: Int, missDistance: Int, orbitingBody: String) {
        self.name = name
        self.size = size
        self.dangerous = dangerous
        self.velocity = velocity
        self.missDistance = missDistance
        self.orbitingBody = orbitingBody
    }
    
    
}
