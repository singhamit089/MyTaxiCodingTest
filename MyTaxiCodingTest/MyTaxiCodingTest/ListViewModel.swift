//
//  ListViewModel.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public protocol ListViewModelInputs {
    var loadPageTrigger: PublishSubject<Void> { get }
}

public protocol ListViewModelOutputs {
    var isLoading: Driver<Bool> { get }
    var elements: BehaviorRelay<[Taxi]> { get }
}

public protocol ListViewModelType {
    var inputs: ListViewModelInputs { get }
    var outputs: ListViewModelOutputs { get }
}

public class ListViewModel: ListViewModelType,ListViewModelInputs,ListViewModelOutputs {
    
    private let disposeBag = DisposeBag()
    private let error = PublishSubject<Error>()
    
    private let p1 = Coordinate(latitude: 53.694865, longitude: 9.757589)
    private let p2 = Coordinate(latitude: 53.394655, longitude: 10.099891)
    
    init() {
        
        loadPageTrigger = PublishSubject<Void>()
        elements = BehaviorRelay<[Taxi]>(value: [])
        let isLoading = ActivityIndicator()
        self.isLoading = isLoading.asDriver()
        
        let pageRequest = loadPageTrigger.asDriver(onErrorJustReturn: ()).flatMap { [weak self] () -> Driver<[Taxi]> in
            
            guard let self = self else {
                return Driver.empty()
            }
            
            self.elements.accept([])
            
            return APIManager.sharedAPI.searchTaxi(p1: self.p1, p2: self.p2)
                .trackActivity(isLoading).asDriver(onErrorDriveWith: Driver.empty()).flatMap({ taxiSearch -> Driver<[Taxi]> in
                    return Single.just(taxiSearch.taxiList).asDriver(onErrorJustReturn: [])
                })
        }
        
        let request = Observable.of(pageRequest.asObservable())
            .merge()
            .share(replay: 1)
        
        let response = request.flatMap { _ -> Observable<[Taxi]> in
            request
                .do(onError: { _error in
                    self.error.onNext(_error)
                }).catchError({ _ -> Observable<[Taxi]> in
                    Observable.empty()
                })
            }.share(replay: 1)
        
        Observable
            .combineLatest(request, response, elements.asObservable()) { _, response, elements in
                return response+elements
            }
            .sample(response)
            .bind(to: elements)
            .disposed(by: disposeBag)
    }
    
    
    public var inputs: ListViewModelInputs { return self }
    public var outputs: ListViewModelOutputs { return self }
    public var loadPageTrigger: PublishSubject<Void>
    public var isLoading: Driver<Bool>
    public var elements: BehaviorRelay<[Taxi]>
}
