//
//  MinPrices.swift
//  testTrand
//
//  Created by Sergio Veliz on 10/26/18.
//  Copyright © 2018 Sergio Veliz. All rights reserved.
//

import Foundation
import ObjectMapper

class MinPrices: Mappable {
    var room = 0
    var price = 0
    var rooms = ""
    
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        room    <- map["room"]
        price    <- map["price"]
        rooms         <- map["rooms"]
    }
}
