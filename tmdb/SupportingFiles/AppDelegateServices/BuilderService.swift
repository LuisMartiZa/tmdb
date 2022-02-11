//
//  BuilderService.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 11/2/22.
//

import UIKit

class BuilderService: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        var success: Bool = false

        if let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UINavigationController(rootViewController: UIViewController())
            window.makeKeyAndVisible()

            appDelegate.window = window

            success = true
        }

        return success
    }
}
