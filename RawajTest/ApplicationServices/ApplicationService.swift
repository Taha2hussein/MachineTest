//
//  ApplicationService.swift
//  A
//

//  Copyright © 2019 A. All rights reserved.
//

import UIKit

class ApplicationService: NSObject, ApplicationDelegate {

    var window: UIWindow?
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
      return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    return false
  }
}
