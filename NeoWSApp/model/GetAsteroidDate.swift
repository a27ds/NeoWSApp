//
//  GetAsteroidDate.swift
//  NeoWSApp
//
//  Created by a27 on 2018-05-07.
//  Copyright © 2018 a27. All rights reserved.
//

import Foundation

class GetAsteroidDate {
    
    static func todaysDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "sv_SE")
        return dateFormatter.string(from: Date())
    }
    
}
