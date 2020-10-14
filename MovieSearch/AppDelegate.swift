//
//  AppDelegate.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let navigationController = UINavigationController()
    let searchViewController = SearchViewController()
    searchViewController.title = "Movies"
    
    navigationController.addChild(searchViewController)
   
    
    window?.rootViewController = navigationController
    
    window?.makeKeyAndVisible()
    
    return true
  }

}

