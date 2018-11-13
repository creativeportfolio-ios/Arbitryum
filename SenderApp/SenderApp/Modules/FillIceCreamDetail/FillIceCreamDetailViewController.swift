//
//  FillIceCreamDetailViewController.swift
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

class FillIceCreamDetailViewController: BaseViewController<FillIceCreamDetailInteractor> {

    ///
    var fillIceCreamDetailRouter: FillIceCreamDetailRouter?

    // MARK: - IBOutlets

    ///
    @IBOutlet weak var NameTextField: UITextField!
    ///
    @IBOutlet weak var weightTextField: UITextField!
    ///
    @IBOutlet weak var colorTextField: UITextField!
    ///
    @IBOutlet weak var flavorTextField: UITextField!
    ///
    @IBOutlet weak var temperatureTextField: UITextField!

    // MARK: - IBActions

    @IBAction func saveTapped(_ sender: Any) {
        guard interactor?.validate(iceCreamField: createiceCreamFieldParameters()) ?? false else { return }
        interactor?.saveData()
    }

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {

        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
    }

    // MARK: - Helper methods

    ///
    func createiceCreamFieldParameters() -> [String: Any] {

        var iceCreamFieldParameters = [String: Any]()
        iceCreamFieldParameters["name"] = NameTextField.text ?? ""
        iceCreamFieldParameters["weight"] = weightTextField.text ?? ""
        iceCreamFieldParameters["color"] = colorTextField.text ?? ""
        iceCreamFieldParameters["flavor"] = flavorTextField.text ?? ""
        iceCreamFieldParameters["temperature"] = temperatureTextField.text ?? ""
        return iceCreamFieldParameters
    }

    /// clear data from screen
    func clearData() {

        NameTextField.text = ""
        weightTextField.text = ""
        colorTextField.text = ""
        flavorTextField.text = ""
        temperatureTextField.text = ""
    }
}

