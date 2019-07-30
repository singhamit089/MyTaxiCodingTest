//
//  Taxi.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation

@objcMembers public class Taxi: NSObject, Codable {
    
    let id:Double
    let location:Coordinate
    let fleetType:String
    let heading:Double

    enum TaxiCodingKey:String,CodingKey {
        case id
        case location
        case fleetType
        case heading
    }
    
    required public init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: TaxiCodingKey.self)
        
        self.id = try values.decode(Double.self, forKey: .id)
        self.location = try values.decode(Coordinate.self, forKey: .location)
        self.fleetType = try values.decode(String.self, forKey: .fleetType)
        self.heading = try values.decode(Double.self, forKey: .heading)
    }
}
