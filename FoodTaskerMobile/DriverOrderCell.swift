//
//  DriverOrderCell.swift
//  FoodTaskerMobile
//
//  Created by Anton Novoselov on 01/05/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import UIKit

class DriverOrderCell: UITableViewCell {
    
    @IBOutlet weak var lbRestaurantName: UILabel!
    @IBOutlet weak var lbCustomerName: UILabel!
    @IBOutlet weak var lbCustomerAddress: UILabel!
    @IBOutlet weak var imgCustomerAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
