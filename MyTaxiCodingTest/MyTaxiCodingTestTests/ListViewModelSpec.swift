//
//  ListViewModelSpec.swift
//  MyTaxiCodingTestTests
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation
@testable import MyTaxiCodingTest
import Moya
import Nimble
import Quick
import RxCocoa
import RxSwift
import RxTest

class ListViewModelSpec: QuickSpec {
    
    override func spec() {
        var sut : ListViewModel!
        var scheduler : TestScheduler!
        var disposeBag: DisposeBag!
        
        beforeEach {
            let bundle = Bundle(for: type(of: self))
            guard let path = bundle.path(forResource: "SearchResponse", ofType: "json") else {
                fatalError("Enable to find json file in the given path")
            }
            stubJsonPath =  path
            
            MyTaxiProvider = MoyaProvider<MyTaxiAPI>(
                stubClosure: MoyaProvider.immediatelyStub,
                plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)]
            )
            
            scheduler = TestScheduler(initialClock: 0)
            SharingScheduler.mock(scheduler: scheduler, action: {
                sut = ListViewModel()
            })
            
            disposeBag = DisposeBag()
        }
        
        afterEach {
            scheduler = nil
            sut = nil
            disposeBag = nil
        }
        
        it("returns 30 items when queried") {
            
            let observer = scheduler.createObserver([Taxi].self)
            
            scheduler.scheduleAt(100, action: {
                sut.outputs.elements.asObservable()
                    .subscribe(observer)
                    .disposed(by: disposeBag)
            })
            
            scheduler.scheduleAt(200) {
                sut.inputs.loadPageTrigger.onNext(())
            }
            
            scheduler.start()
            
            let results = observer.events.last.map { event in
                event.value.element!.count
            }
            
            expect(results) == 30
        }
        
    }
}
