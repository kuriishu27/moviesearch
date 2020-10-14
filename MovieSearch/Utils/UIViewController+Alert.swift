//
//  UIViewController+Alert.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 07/10/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import UIKit

extension UIViewController {
  //Show a basic alert
  func showAlert(alertText : String, alertMessage : String) {
    let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
    //Add more actions as you see fit
    self.present(alert, animated: true, completion: nil)
  }
}
