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

public struct ListViewModel: ListViewModelType,ListViewModelInputs,ListViewModelOutputs {
    
    private let disposeBag = DisposeBag()
    private let error = PublishSubject<Error>()
    private var searchResult:TaxiSearch?
    
    init() {
        
        loadPageTrigger = PublishSubject<Void>()
        elements = BehaviorRelay<[Taxi]>(value: [])
        let isLoading = ActivityIndicator()
        self.isLoading = isLoading.asDriver()
        
        let pageRequest = isLoading.asObservable().sample(loadPageTrigger).flatMap { _isLoading -> Driver<[Taxi]> in
            
            if !_isLoading {
                
                // Make API Call here
            }
            
            return Driver.empty()
        }
    }
    
    
    public var inputs: ListViewModelInputs { return self }
    public var outputs: ListViewModelOutputs { return self }
    public var loadPageTrigger: PublishSubject<Void>
    public var isLoading: Driver<Bool>
    public var elements: BehaviorRelay<[Taxi]>
}
