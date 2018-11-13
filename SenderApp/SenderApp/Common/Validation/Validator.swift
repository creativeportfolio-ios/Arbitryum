//
//  Validator.swift
//  
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

///
enum CommonValidationType {
    ///
    case empty
    ///
    case minLength
    ///
    case maxLength
    ///
    case notValid
    ///
    case shouldContain
    ///
    case notMatched
    ///
    case none
}

///
class Validator: NSObject {

    // MARK: - Variables
    
    // MARK: Passcode Variables

    /// Passcode regex
    private static let passcodeRegEx = "^[0-9]"
    /// Minimum length of password
    static let passcodeLength = 6

    // MARK: Name Variables
    /// Name regex
    private static let nameRegEx = "^[a-zA-Z][a-zA-Z]+$"
    /// Minimum length of name
    private static let nameMinLength = 1
    /// Maximum length of name
    private static let nameMaxLength = 10

    // MARK: Phone Variables
    /// Name regex
    private static let phoneRegEx = "^[0-9]{2,}"
    /// Minimum length of number
    private static let numberMinLength = 1
    /// Maximum length of number
    private static let numberMaxLength = 5

    // MARK: - Validation Methods

    /// Check if stringValue is valid or not for common use cases like:  empty string
    ///
    /// - Parameter stringValue: stringValue to be validated
    /// - Returns:
    ///    - isValid: true: correct stringValue false: incorrect stringValue
    ///    - message: error message
    ///    - type: error type
    static func validate(stringValue: String)  -> (isValid: Bool, message: String?, type: CommonValidationType) {

        // Check Empty
        if stringValue.isEmpty {
            return (false, String(format: ValidationMessages.Common.empty, stringValue), .empty)
        }
        // Success
        return (true, nil, .none)
    }

    /// Check if name is valid or not
    ///
    /// - Parameter
    ///     - name: name to be validated
    ///     - customName: Pass custom name like:- FirstName, MiddleName etc.
    /// - Returns:
    ///    - isValid: true:- correct name false:- incorrect name
    ///    - message: error message
    ///    - type: error type
    static func validate(name: String, customName: String = "Name") -> (isValid: Bool, message: String?, type: CommonValidationType) {

        // Check Empty
        if name.isEmpty {
            return (false, String(format: ValidationMessages.Name.empty, customName), .empty)
        } else if name.count < Validator.nameMinLength {
            return (false, String(format: ValidationMessages.Name.minLength, customName, nameMinLength), .minLength)
        } else if name.count > Validator.nameMaxLength {
            return (false, String(format: ValidationMessages.Name.maxLength, customName, nameMaxLength), .maxLength)
        }
        // Check Regex///
        struct weight {
            static let empty = "Please enter %@"
            static let minLength = "%@ should be minimum %d in length"
            static let maxLength = "%@ should be maximum %d in length"
        }
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", Validator.nameRegEx)
        if !namePredicate.evaluate(with: name) {
            return (false, String(format: ValidationMessages.Name.notValid, customName), .notValid)
        }
        // Success
        return (true, nil, .none)
    }

    /// Check if weight is valid or not
    ///
    /// - Parameter phone: phone to be validated
    /// - Returns:
    ///    - isValid: true:- correct phone false:- incorrect phone
    ///    - message: error message
    ///    - type: error type
    static func validate(number: String, customName: String = "Number") -> (isValid: Bool, message: String?, type: CommonValidationType) {

        // Check Empty
        if number.isEmpty {
            return (false, ValidationMessages.Number.empty, .empty)
        }
        // Check Regex
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", Validator.phoneRegEx)
        if !phonePredicate.evaluate(with: number) {
            return (false, String(format: ValidationMessages.Number.notValid, customName), .notValid)
        }
        // Success
        return (true, nil, .none)
    }

    /// check if color is empty or not
    ///
    /// - Parameters:
    ///   - color: color string
    /// - Returns:
    ///    - isValid: true
    ///    - message: error message
    ///    - type: error type
    static func validate(color: String, customName: String = "color") -> (isValid: Bool, message: String?, type: CommonValidationType) {

        // Check Empty
        if color.isEmpty {
            return (false, ValidationMessages.color.empty, .empty)
        }
        // Success
        return (true, nil, .none)
    }

    /// check if color is empty or not
    ///
    /// - Parameters:
    ///   - flavor: flavor string
    /// - Returns:
    ///    - isValid: true
    ///    - message: error message
    ///    - type: error type
    static func validate(flavorString: String, flavorCustomName: String = "flavor") -> (isValid: Bool, message: String?, type: CommonValidationType) {

        // Check Empty
        if flavorString.isEmpty {
            return (false, ValidationMessages.flavor.empty, .empty)
        }
        // Success
        return (true, nil, .none)
    }

    /// check if color is empty or not
    ///
    /// - Parameters:
    ///   - temperature: temperature string
    /// - Returns:
    ///    - isValid: true
    ///    - message: error message
    ///    - type: error type
    static func validate(temperatureString: String, temperatureCustomName: String = "temperature") -> (isValid: Bool, message: String?, type: CommonValidationType) {

        // Check Empty
        if temperatureString.isEmpty {
            return (false, ValidationMessages.temperature.empty, .empty)
        }
        // Success
        return (true, nil, .none)
    }

}
