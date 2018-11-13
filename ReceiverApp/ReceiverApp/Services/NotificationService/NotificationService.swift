//
//  NotificationService.swift
//
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
import UserNotifications
import CocoaLumberjack

///
class NotificationService: NSObject {
    
    // MARK: - Variable
    
    ///
    private var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ///
    private var router: MainRouter?
    ///
    private let center = UNUserNotificationCenter.current()
    ///
    private var window: UIWindow? {
        return (UIApplication.shared.delegate as? AppDelegate)?.window
    }
    ///
    private var rootViewController: UIViewController? {
        return window?.rootViewController
    }
    /// Handles all delegate related to UIApplication or Appdelegate
    weak var applicationDelegate: ApplicationDelegate?

    // Following are constant variables helping in setting notification methods and validation methods.

    /// Prefix date used to form a complete Date object from the bed time and wake up time. Only used for comparison purposes and does not have any relevance otherwise.
    private let prefixDate = "2-1-2000"

    /// Static time when the sleep rating notification has to be fired with the hour being 8 and minutes being 30.
    private let notificationTime = (hour: 8, minute: 30)

    /// The weekday range of the app where 0 is Sunday, 1 is Monday and so forth.
    private let appWeekdayRange = 0...6

    // MARK: - Life Cycle Methods

    ///
    convenience init(router: MainRouter?, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.init()
        
        self.router = router
        self.launchOptions = launchOptions
    }

    /// Notification Configuration
    func notificationConfiguration() {
        // Assign delegate
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.delegate = self

        // Ask for permission
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { [weak self](granted, error) in
            if granted {
                DDLogVerbose("Notification permission granted")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                DDLogError(error?.localizedDescription ?? "Notification permission denied")
                self?.showAlert(message: "Please allow notification permission to SenderApp", buttonTitles: ["Setting", "Cancel"], customAlertViewTapButtonBlock: { (index) in
                    if index == 0 {
                        // open url
                    }
                })
            }
        })
    }

    // MARK: - Local Notification
    
    /// Fire local notification
    ///
    /// - Parameters:
    ///   - notification: notification object
    ///   - inSeconds: duration after which notification needs to be fired where 1.0 seconds is default value
    ///   - identifier: Unique identifier for a particular notification
    ///   - shouldRepeat: whether the notification should repeat or not. defualt value will be *false*.
    ///   - completion: returns completion block
    func fireLocalNotification(notification: UNMutableNotificationContent, inSeconds: TimeInterval = 1.0, atDate: DateComponents?, identifier: String, shouldRepeat: Bool = false, completion: @escaping (_ Success: Bool) -> Void) {
        let trigger: UNNotificationTrigger
        if let atDate = atDate {
            trigger = UNCalendarNotificationTrigger(dateMatching: atDate, repeats: shouldRepeat)
        } else {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: shouldRepeat)
        }
        let request = UNNotificationRequest(identifier: identifier, content: notification, trigger: trigger)
        center.add(request) { (error) in
            if let error = error {
                DDLogError(error.localizedDescription)
                completion(false)
                return
            }
            completion(true)
        }
    }

    // MARK: - Alert methods
    ///
    func showInternetAlert() {
        showOkAlert(message: "Please check you're internet connection")
    }
    
    ///
    func showOkAlert(message: String) {
        DispatchQueue.main.async { 
            guard let topVC = UIApplication.getTopMostViewController() else { return }
            topVC.showOkAlert(message: message)
        }
    }

    ///
    func showConfirmationAlert(withMessage message: String, yesCompletion: (() -> Void)? = nil, noCompletion: (() -> Void)? = nil) {
        DispatchQueue.main.async { 
            guard let topVC = UIApplication.getTopMostViewController() else { return }
            topVC.showProceedAlert(title: message, yesCompletion: yesCompletion, noCompletion: noCompletion)
        }
    }

    ///
    func showAlert(forTitle title: String = "",
                   message: String,
                   buttonTitles: [String],
                   customAlertViewTapButtonBlock: ((Int) -> Void)?, isHighPriority: Bool = false) {
        DispatchQueue.main.async {
            guard let topVC = UIApplication.getTopMostViewController() else { return }
            topVC.showAlert(forTitle: title, message: message, buttonTitles: buttonTitles, customAlertViewTapButtonBlock: customAlertViewTapButtonBlock, isHighPriority: isHighPriority)
        }
    }

    // MARK: - Notification Related Methods
    
    /// Method search for particular notification and return true/false value in completion handler
    ///
    /// - Parameters:
    ///   - identifier: Notification identifier
    ///   - completionHandler: returns completion handler with bool value
    func searchIfNotificationAlreadyScheduleFor(identifier: String, completionHandler: @escaping (Bool) -> Void) {
        
        center.getPendingNotificationRequests { (notifications) in
            print("Count: \(notifications.count)")
            for item in notifications where item.identifier == identifier {
                completionHandler(true)
                return
            }
            completionHandler(false)
        }
    }
    
    /// Removes notification from notification stack
    ///
    /// - Parameter identifier: notification identifier that needs to be removed
    func removeNotifications(identifiers: [String]) {
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}

// MARK: - Notification Delegate Methods

extension NotificationService: UNUserNotificationCenterDelegate {
    
    ///
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
        guard let attachment = notification.request.content.attachments.first else {
            return
        }
        print(attachment)
    }
    
    ///
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Delivers a notification to an app running in the foreground.
        switch response.notification.request.identifier {
        default: print(response.notification.request.identifier)
        }
    }
}

///
extension NotificationService: ApplicationDelegate {

    ///
    func fetchedApnsDeviceToken(value: String, errorMsg: String?) {
        guard let errorMsg = errorMsg else {
            print("APNs device token: \(value)")
            return
        }
        print("Failed to fetch device token: - ", errorMsg)
    }

    ///
    func didReceiveRemoteNotification(withData data: [AnyHashable: Any], application: UIApplication) {
        // Print notification payload data
        if let response = data["aps"] as? [AnyHashable: Any] {
            print("\n Push notifiation response: - \n", response)
        }
    }
}
