//
//  UIViewController+Alert.swift
//
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

///
extension UIViewController {

    // MARK: - Alert Methods

    ///
    private func showAlert(forTitle title: String = "",
                           message: String,
                           actions: [UIAlertAction]) {

        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)

        actions.forEach { alertController.addAction($0) }

        alertController.modalPresentationStyle = .custom
        alertController.modalTransitionStyle = .crossDissolve
        present(alertController, animated: true, completion: nil)
    }

    /// Method to show native alert
    ///
    /// - Parameters:
    ///   - title: title of Alert
    ///   - message: description of the Alert
    ///   - buttonTitles: Array of buttons
    ///   - customAlertViewTapButtonBlock: returns completion handler
    ///   - isHighPriority: Its a unique parameter that dismiss any alert or view presenting
    ///     over the current view controller. Only to be used for high priority alerts.
    func showAlert(forTitle title: String = "",
                   message: String,
                   buttonTitles: [String],
                   customAlertViewTapButtonBlock: ((Int) -> Void)?, isHighPriority: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            var actions = [UIAlertAction]()
            for buttonIndex in 0..<(buttonTitles.count) {
                let alertAction = UIAlertAction(title: buttonTitles[buttonIndex],
                                                style: UIAlertAction.Style.default,
                                                handler: { _ in
                                                    customAlertViewTapButtonBlock?(buttonIndex)
                })
                actions.append(alertAction)
            }
            if isHighPriority {
                guard let presentedVC = self?.presentedViewController else {
                    self?.showAlert(forTitle: title, message: message, actions: actions)
                    return
                }
                presentedVC.dismiss(animated: true, completion: {
                    self?.showAlert(forTitle: title, message: message, actions: actions)
                })
            } else {
                self?.showAlert(forTitle: title, message: message, actions: actions)
            }
        }
    }

    ///
    func showDestructiveConfirmAlert(title: String = "",
                                     message: String,
                                     cancelButtonTitle: String,
                                     confirmButtonTitle: String,
                                     customAlertViewTapButtonBlock: ((Int) -> Void)?) {

        var actions = [UIAlertAction]()
        let cancelAction = UIAlertAction(title: cancelButtonTitle,
                                         style: UIAlertAction.Style.default,
                                         handler: { _ in
                                            customAlertViewTapButtonBlock?(0)
        })
        actions.append(cancelAction)

        let confirmAction = UIAlertAction(title: confirmButtonTitle,
                                          style: UIAlertAction.Style.destructive,
                                          handler: { _ in
                                            customAlertViewTapButtonBlock?(1)
        })
        actions.append(confirmAction)
        showAlert(forTitle: title, message: message, actions: actions)
    }

    /**
     Call to show an alert with a single OK button and no action blocks attached.

     - parameter message: The message to be shown in the alert dialog
     */
    func showOkAlert(message: String) {

        showAlert(message: message,
                  buttonTitles: ["Okay"],
                  customAlertViewTapButtonBlock: nil)
    }

    // MARK: - Retry Alert

    /// Show retry alert
    ///
    /// - Parameters:
    ///   - title: Title to be shown in the alert
    ///   - restartFunction: function that needs to be executed on retry tap.
    func showRetryAlert(title: String, restartFunction: @escaping (() -> Void)) {
        showAlert(message: title, buttonTitles: ["Retry"], customAlertViewTapButtonBlock: { (_) in
            restartFunction()
        }, isHighPriority: true)
    }

    /// Shows a yes/no alert with a custom optional completion for both yes and no actions.
    ///
    /// - Parameters:
    ///   - title: Title to be displayed.
    ///   - yesCompletion: actions to be performed when yes is tapped.
    ///   - noCompletion: actions to be performed when no is tapped.
    func showProceedAlert(title: String, yesCompletion: (() -> Void)? = nil, noCompletion: (() -> Void)? = nil) {
        showAlert(message: title, buttonTitles: ["Yes", "No"], customAlertViewTapButtonBlock: { (index) in
            if index == 0 { // Yes tapped
                guard let yesCompletion = yesCompletion else { return }
                yesCompletion()
            } else {
                guard let noCompletion = noCompletion else { return }
                noCompletion()
            }
        }, isHighPriority: true)
    }

    ///
    func showCustomAlert(withTitle title: String = "", message: String, attributedString: NSAttributedString? = nil, alertIcon: UIImage? = nil, buttonTitle: String = "Okay", otherButtonTitles: [String]? = nil, customAlertViewTapButtonBlock: ((Int) -> Void)? = nil) {
        let alert: CustomAlertVC = CustomAlertVC.init(WithTitle: title, message: message, attrString: attributedString, alertIcon: alertIcon, cancelButtonTitle: buttonTitle, otherButtonTitles: otherButtonTitles)
        alert.buttonDidTappedBlock = { buttonIndex in
            if customAlertViewTapButtonBlock != nil {
                customAlertViewTapButtonBlock?(buttonIndex)
            }
        }
        alert.modalPresentationStyle = .custom
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true, completion: nil)
    }
}
