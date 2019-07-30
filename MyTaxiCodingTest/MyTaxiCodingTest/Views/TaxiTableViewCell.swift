//
//  TaxiTableViewCell.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import UIKit

class TaxiTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taxiImageView: UIImageView!
    
    @IBOutlet weak var taxiTitleLabel: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var heading: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(taxi:Taxi) {

        self.taxiTitleLabel.text = "\(taxi.fleetType) : \(taxi.id)"
        self.location.text = "Lat : \(taxi.location.latitude) | Long : \(taxi.location.longitude)"
        self.heading.text = "Heading towards : \(taxi.heading)"
        
        if taxi.fleetType == "TAXI" {
            self.imageView?.image = UIImage(named: "taxi")
        } else {
            self.imageView?.image = UIImage(named: "carpool")
        }
    }
    
}
