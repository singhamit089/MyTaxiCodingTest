//
//  TaxiSearch.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation

@objcMembers public class TaxiSearch:Codable {
    
    let taxiList:[Taxi]
    
    enum TaxiSearchCokingKey:String,CodingKey  {
        case taxiList = "poiList"
    }
    
    required public init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: TaxiSearchCokingKey.self)
        self.taxiList = try values.decode([Taxi].self, forKey: .taxiList)
    }
}
