//
//  FillIceCreamDetailRouter.swift
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

/// Implementation of FillIceCreamDetailRouting
class FillIceCreamDetailRouter {

    ///
    private var mainRouter: MainRouter?
    ///
    private let notificationService: NotificationService
    ///
    weak private var navigationController: UINavigationController?

    // MARK: - Life Cycle Method

    ///
    init(mainRouter: MainRouter? = nil, notificationService: NotificationService) {

        self.mainRouter = mainRouter
        self.notificationService = notificationService
    }

    // MARK: - Assemble Methods

    ///
    func assembleInitialScreen() -> UINavigationController? {

        navigationController = R.storyboard.fillIceCreamDetail.instantiateInitialViewController()
        let loginVC = assembleFillIceCreamScreen()
        navigationController?.setViewControllers([loginVC], animated: true)
        return navigationController
    }

    ///
    func assembleFillIceCreamScreen() -> UIViewController {

        guard let vc = R.storyboard.fillIceCreamDetail.fillIceCreamDetailStoryboard() else {
            fatalError("Unable to get fillIceCreamDetail.")
        }

        let interactor = FillIceCreamDetailInteractor(fillIceCreamDetailRouter: self)
        interactor.view = vc
        vc.interactor = interactor
        return vc
    }
}
