//
//  AdvertCell.swift
//  testTrand
//
//  Created by Sergio Veliz on 10/26/18.
//  Copyright © 2018 Sergio Veliz. All rights reserved.
//

import Foundation
import UIKit

class AdvertCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageAdvert: UIImageView!
    @IBOutlet weak var oneRoomLabel: UILabel!
    @IBOutlet weak var twoRoomLabel: UILabel!
    @IBOutlet weak var threeRoomLabel: UILabel!
    @IBOutlet weak var FourRoomLabel: UILabel!
    @IBOutlet weak var startPrice: UILabel!
    @IBOutlet weak var oneFlatPrice: UILabel!
    @IBOutlet weak var twoFlatPrice: UILabel!
    @IBOutlet weak var threeFlatPrice: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var metroNameLabel: UILabel!
    @IBOutlet weak var timeFromMetro: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
