//
//  MyTaxiAPIProtocol.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation
import RxSwift

public protocol MyTaxiAPIProtocols {
    func searchTaxi(p1: Coordinate, p2: Coordinate) -> Single<TaxiSearch>
}

