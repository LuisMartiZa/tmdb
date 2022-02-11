//
//  AppDelegate.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 11/2/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var services: [UIApplicationDelegate] = AppDelegateServicesConfig.services

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var success = true

        for service in services {
            let serviceSuccess = service.application?(application, didFinishLaunchingWithOptions: launchOptions)
            success = success && (serviceSuccess ?? true)
        }

        return success
    }

    func applicationWillResignActive(_ application: UIApplication) {
        for service in services {
            service.applicationWillResignActive?(application)
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        for service in services {
            service.applicationDidEnterBackground?(application)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        for service in services {
            service.applicationWillEnterForeground?(application)
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        for service in services {
            service.applicationDidBecomeActive?(application)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        for service in services {
            service.applicationWillTerminate?(application)
        }
    }
}
