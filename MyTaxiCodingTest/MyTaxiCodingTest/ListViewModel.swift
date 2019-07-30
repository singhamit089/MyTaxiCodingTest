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

public struct ListViewModel {
    
}
