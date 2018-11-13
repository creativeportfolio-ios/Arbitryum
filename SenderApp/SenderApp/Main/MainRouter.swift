//
//  MainRouter.swift
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

/// Implementation of MainRouting
final class MainRouter {

    // MARK: - Variables

    ///
    private let launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ///
    private let window: UIWindow
    //
    private var rootVC: UIViewController? {
        return window.rootViewController
    }

    ///
    private lazy var notificationService: NotificationService = NotificationService(router: self, launchOptions: launchOptions)

    // MARK: - Life Cycle Methods

    /**
     Initialize the router with required dependencies

     - parameter window: The root window of the application
     */
    init(window: UIWindow, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {

        self.window = window
        self.launchOptions = launchOptions
    }

    // MARK: - Navigaiton methods

    /// Call to determine and present the root view for this application. Currently that will be either the tabBar or the initial onboarding slideshow.
    func setInitialViewController() {

        // Show other VC
        presentUserManagement()
    }

    /// Set rootVC to user managment initial VC
    func presentUserManagement() {

        let fillIceCreamDetailRouter = FillIceCreamDetailRouter(mainRouter: self, notificationService: notificationService)
        window.rootViewController = fillIceCreamDetailRouter.assembleInitialScreen()
    }
}
