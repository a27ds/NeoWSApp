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
    func sizeTeller() -> Float {
        let small : Float = 25.0
        let medium : Float = 999.0
        let big : Float = 2000.0
        
        if self.size <= small {
            return 0.1
        } else if self.size <= medium {
            return 0.4
        } else if self.size <= big {
            return 0.7
        } else {
            return 1.0
        }
    }
    
    func getYesOrNoString() -> String {
        let yes : String = "Yes"
        let no : String = "No"
        
        if self.dangerous {
            return yes
        }
        return no
    }
    
}





























