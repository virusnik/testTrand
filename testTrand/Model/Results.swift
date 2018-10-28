//
//  Results.swift
//  testTrand
//
//  Created by Sergio Veliz on 10/25/18.
//  Copyright © 2018 Sergio Veliz. All rights reserved.
//

import Foundation
import ObjectMapper

class Results: Mappable {
    
    var builder = Builder()
    var id = ""
    var crm_id = ""
    var name = ""
    var guid = ""
    var region = Builder()
    var subways: [Subways] = [Subways]()
    var address = ""
    var deadline = ""
    var finishing = ""
    var min_price = ""
    var apart_count = ""
    var min_prices: [MinPrices] = [MinPrices]()
    var labels = ""
    var image = ""
    var сontractTypes = ""
    var marked = false
    var payment = ""
    var advantages = ""
    var latitude = ""
    var longitude = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        builder    <- map["builder"]
        id    <- map["id"]
        crm_id  <- map["crm_id"]
        name    <- map["name"]
        guid    <- map["guid"]
        region  <- map["region"]
        subways <- map["subways"]
        address <- map["address"]
        deadline    <- map["deadline"]
        finishing   <- map["finishing"]
        min_price   <- map["min_price"]
        apart_count <- map["apart_count"]
        min_prices   <- map["min_prices"]
        labels  <- map["label"]
        image     <- map["image"]
        сontractTypes   <- map["сontractTypes"]
        marked  <- map["marked"]
        payment <- map["payment"]
        advantages  <- map["advantages"]
        latitude    <- map["latitude"]
        longitude   <- map["longitude"]
    }
    func getPictureURL() -> URL {
//        print(picture)
        
        return URL(string: image) ?? URL(fileURLWithPath:"")
    }
//    func getThumbnailUrl() -> URL {
//        return URL(string: image)!
//    }
}
