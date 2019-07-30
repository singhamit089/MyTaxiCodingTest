//
//  APIManager.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

@objc public class APIManager:NSObject, MyTaxiAPIProtocols {
    
    @objc static let sharedAPI = APIManager()
    
    public func searchTaxi(p1: Coordinate,p2: Coordinate ) -> Single<[Taxi]> {
        
        return MyTaxiProvider.rx.request(MyTaxiAPI.taxiSearch(p1: p1, p2: p2))
            .map(TaxiSearch.self)
            .observeOn(MainScheduler.instance)
            .flatMap({ searchResult -> Single<[Taxi]> in
                return Single.just(searchResult.taxiList)
            })
    }
    
    @objc func searchTaxi(p1: Coordinate,p2: Coordinate, completion: @escaping (_ listOfTaxi: [Taxi]?,_ error: String?)->()){
        
        _ = MyTaxiProvider.rx.request(MyTaxiAPI.taxiSearch(p1: p1, p2: p2))
            .map(TaxiSearch.self)
            .observeOn(MainScheduler.instance)
            .flatMap({ searchResult -> Single<[Taxi]> in
                completion(searchResult.taxiList, nil)
                return Single.just(searchResult.taxiList)
            }).asDriver(onErrorJustReturn: []).drive()
    }
}
