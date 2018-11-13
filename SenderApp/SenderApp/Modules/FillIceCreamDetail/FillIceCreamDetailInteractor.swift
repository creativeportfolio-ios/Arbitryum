//
//  FillIceCreamDetailInteractor.swift
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase
import FirebaseDatabase

/// Implementation of FillIceCreamDetailInteracting
class FillIceCreamDetailInteractor: Interacting {

    // MARK: - Variable

    ///
    var view: FillIceCreamDetailViewController?

    ///
    private var router: FillIceCreamDetailRouter?

    // MARK: - Variables

    ///
    var databaseRefer: DatabaseReference!
    ///
    var databaseHandle: DatabaseHandle!
    ///
    var nameListArr: [[String: String]] = []

    // MARK: - Life Cycle Methods

    init(fillIceCreamDetailRouter: FillIceCreamDetailRouter) {

        self.router = fillIceCreamDetailRouter
        databaseRefer = Database.database().reference()
    }

    // MARK: - Other methods

    /// Methods validates if the entered values are correct or not
    /// - Parameter loginFields: fields that are needed to be validated
    /// - Returns: true -> valid, false -> invalid
    func validate(iceCreamField: [String: Any]) -> Bool {

        let registerFields = JSON(iceCreamField)

        // Name
        let firstNameValidation = Validator.validate(name: registerFields["name"].stringValue, customName: "name")
        guard firstNameValidation.isValid else {
            view?.showOkAlert(message: firstNameValidation.message ?? "")
            return false
        }

        // weight Name
        let weightValidation = Validator.validate(number: registerFields["weight"].stringValue, customName: "Number")
        guard weightValidation.isValid else {
            view?.showOkAlert(message: weightValidation.message ?? "")
            return false
        }

        // color address
        let colorValidation = Validator.validate(color: registerFields["color"].stringValue, customName: "color")
        guard colorValidation.isValid else {
            view?.showOkAlert(message: colorValidation.message ?? "")
            return false
        }

        // flavor
        let flavorValidation = Validator.validate(flavorString: registerFields["flavor"].stringValue)
        guard flavorValidation.isValid else {
            view?.showOkAlert(message: flavorValidation.message ?? "")
            return false
        }

        // temperature
        let temperatureValidation = Validator.validate(temperatureString: registerFields["temperature"].stringValue)
        guard temperatureValidation.isValid else {
            view?.showOkAlert(message: temperatureValidation.message ?? "")
            return false
        }

        return true
    }

    /// Save data on firebase
    func saveData() {
        let celsiusString = "° C" // it can be added in localizable file for all string
        let temperatureString = "\(view?.temperatureTextField.text ?? "0") \(celsiusString)"
        databaseRefer.child("IceCreamDetail").childByAutoId().setValue(["name": view?.NameTextField.text, "weight": view?.weightTextField.text, "color": view?.colorTextField.text, "flavor": view?.flavorTextField.text,"temperature": temperatureString], withCompletionBlock: { (error, data) in
            if let error = error {
                print("Error:", error.localizedDescription)
            } else {
                self.view?.clearData()
                print("Added")
            }
        })
    }
}
