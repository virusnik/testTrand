//
//  Response.swift
//  testTrand
//
//  Created by Sergio Veliz on 10/25/18.
//  Copyright © 2018 Sergio Veliz. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchResponse: Mappable {
    
    var errors = ""
    var data = DataResult()
    
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        errors    <- map["errors"]
        data    <- map["data"]
    }
}
