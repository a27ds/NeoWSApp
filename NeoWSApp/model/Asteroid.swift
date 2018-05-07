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
    
    // Funktion som bestämmer om asteroiden är, small, medium, big eller huge och returnerar en String med den bestämda storleken.
    func sizeTeller() -> String {
        let small : Float = 25.0
        let medium : Float = 999.0
        let big : Float = 2000.0
        
        if self.size <= small {
            return "Small"
        } else if self.size <= medium {
            return "medium"
        } else if self.size <= big {
            return "Big"
        } else {
            return "Huge"
        }
    }
    
}
