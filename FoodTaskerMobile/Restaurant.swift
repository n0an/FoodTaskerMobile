//
//  Restaurant.swift
//  FoodTaskerMobile
//
//  Created by Anton Novoselov on 01/05/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import Foundation
import SwiftyJSON

class Restaurant {
    
    var id: Int?
    var name: String?
    var address: String?
    var logo: String?
    
    init(json: JSON) {
        self.id         = json["id"].int
        self.name       = json["name"].string
        self.address    = json["address"].string
        self.logo       = json["logo"].string
    }
}

