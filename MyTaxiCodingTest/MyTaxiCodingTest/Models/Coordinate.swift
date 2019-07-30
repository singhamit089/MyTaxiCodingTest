//
//  Coordinate.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation

public struct Coordinate: Codable {

    let latitude:Double
    let longitude:Double
    
    enum CoordinateCodingKey:String,CodingKey {
        case latitude
        case longitude
    }
    
    public init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CoordinateCodingKey.self)
        
        self.latitude = try values.decode(Double.self, forKey: .latitude)
        self.longitude = try values.decode(Double.self, forKey: .longitude)
    }
}
