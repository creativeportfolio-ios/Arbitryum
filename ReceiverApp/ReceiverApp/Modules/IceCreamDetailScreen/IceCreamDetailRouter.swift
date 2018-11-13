//
//  IceCreamDetailRouter.swift
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

/// Implementation of IceCreamDetailRouting
class IceCreamDetailRouter {

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

        navigationController = R.storyboard.iceCreamDetail.instantiateInitialViewController()
        let loginVC = assembleIceCreamDetailScreen()
        navigationController?.setViewControllers([loginVC], animated: true)
        return navigationController
    }

    ///
    func assembleIceCreamDetailScreen() -> UIViewController {

        guard let vc = R.storyboard.iceCreamDetail.iceCreamDetailStoryboard() else {
            fatalError("Unable to get iceCreamDetail.")
        }

        let interactor = IceCreamDetailInteractor(iceCreamDetailRouter: self)
        interactor.view = vc
        vc.interactor = interactor
        return vc
    }

}
