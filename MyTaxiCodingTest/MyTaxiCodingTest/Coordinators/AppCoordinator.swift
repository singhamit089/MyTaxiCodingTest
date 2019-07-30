//
//  AppCoordinator.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import RxSwift
import UIKit

class AppCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let rootTabBarCoordinator = RootTabBarCoordinator(window: window)
        return coordinate(to: rootTabBarCoordinator)
    }
}

