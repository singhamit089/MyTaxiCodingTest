//
//  Coordinate.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation

@objcMembers public class Coordinate: NSObject, Codable {

    let latitude:Double
    let longitude:Double
    
    enum CoordinateCodingKey:String,CodingKey {
        case latitude
        case longitude
    }
    
    required public init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CoordinateCodingKey.self)
        
        self.latitude = try values.decode(Double.self, forKey: .latitude)
        self.longitude = try values.decode(Double.self, forKey: .longitude)
    }
    
    public init(latitude:Double,longitude:Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
