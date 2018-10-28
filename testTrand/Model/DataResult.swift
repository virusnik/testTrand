//
//  Data.swift
//  testTrand
//
//  Created by Sergio Veliz on 10/25/18.
//  Copyright © 2018 Sergio Veliz. All rights reserved.
//

import Foundation
import ObjectMapper

class DataResult: Mappable {
    
    var apartmentsCount = 0
    var blocksCount = 0
    var results: [Results] = [Results]()
    
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        apartmentsCount    <- map["apartmentsCount"]
        blocksCount    <- map["blocksCount"]
        results         <- map["results"]
    }
    
}
