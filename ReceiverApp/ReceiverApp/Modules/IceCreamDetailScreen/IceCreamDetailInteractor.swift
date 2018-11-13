//
//  IceCreamDetailInteractor.swift
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit


/// Implementation of IceCreamDetailInteracting
class IceCreamDetailInteractor: Interacting {

    // MARK: - Variable

    ///
    var view: IceCreamDetailViewController?

    ///
    private var router: IceCreamDetailRouter?

    // MARK: - Life Cycle Methods

    init(iceCreamDetailRouter: IceCreamDetailRouter) {

        self.router = iceCreamDetailRouter
    }
}
