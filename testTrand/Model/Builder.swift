//
//  Builder.swift
//  testTrand
//
//  Created by Sergio Veliz on 10/25/18.
//  Copyright © 2018 Sergio Veliz. All rights reserved.
//

import Foundation
import ObjectMapper

class Builder: Mappable {
    
    var guid = ""
    var name = ""
    var crm_id = 0
    var id = ""
    
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        guid    <- map["guid"]
        name    <- map["name"]
        crm_id         <- map["crm_id"]
        id  <- map["id"]
    }
    
}
