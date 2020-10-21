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
//    1.
    window = UIWindow(frame: UIScreen.main.bounds)
//    2.
    
    let movieFactory = MovieFactoryFromJSONImpl()
    let moviePrester = MoviesPresenterImpl(movieFactory)
    let searchViewController = SearchViewController(movieFactory: movieFactory, moviePresenter: moviePrester)
    searchViewController.title = "Movies"
    let navigationController = UINavigationController(rootViewController: searchViewController)
//   3
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }

}

