//
//  RootTabBarCoordinator.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import RxSwift
import UIKit

class RootTabBarCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let tabBarController = UITabBarController()
        
        let listViewController = ListViewController()
        let mapViewController = MapViewController(nibName: String(describing: MapViewController.self), bundle: nil)
        
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: listViewController),
            UINavigationController(rootViewController: mapViewController)
        ]
        
        let listTabbaritem = UITabBarItem()
        listTabbaritem.title = "List"
        listTabbaritem.image = UIImage(named: "icons8-list-50")
        
        let mapTabbaritem = UITabBarItem()
        mapTabbaritem.title = "Map"
        mapTabbaritem.image = UIImage(named: "icons8-map-marker-80")
        
        tabBarController.viewControllers?[0].tabBarItem = listTabbaritem
        tabBarController.viewControllers?[1].tabBarItem = mapTabbaritem
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = UIColor.white
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
}

