//
//  Subways.swift
//  testTrand
//
//  Created by Sergio Veliz on 10/25/18.
//  Copyright © 2018 Sergio Veliz. All rights reserved.
//

import Foundation
import ObjectMapper

class Subways: Mappable {
    var guid = ""
    var name = ""
    var crm_id = 0
    var id = ""
    var distanceTiming = 0
    
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        guid    <- map["guid"]
        name    <- map["name"]
        crm_id         <- map["crm_id"]
        id  <- map["id"]
        distanceTiming <- map["distance_timing"]
    }
}
