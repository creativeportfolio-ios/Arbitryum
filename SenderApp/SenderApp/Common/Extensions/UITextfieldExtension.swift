//
//  UITextfieldExtension.swift
//  
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
///
private var maxLengths = NSMapTable<UITextField, NSNumber>(keyOptions: NSPointerFunctions.Options.weakMemory, valueOptions: NSPointerFunctions.Options.strongMemory)

extension UITextField {

    /// Set Placeholder color
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: newValue ?? .lightGray])
        }
    }

    // MARK: - Manage length of Textfield

    /// To set max length of text in textfields in storyboard
    @IBInspectable var maxLengthInspectable: Int {
        get {
            return maxLength ?? Int.max
        }
        set {
            maxLength = newValue
        }
    }

    ///
    var maxLength: Int? {
        get {
            return maxLengths.object(forKey: self)?.intValue
        }
        set {
            removeTarget(self, action: #selector(limitLength), for: .editingChanged)
            if let newValue = newValue {
                maxLengths.setObject(NSNumber(value: newValue), forKey: self)
                addTarget(self, action: #selector(limitLength), for: .editingChanged)
            } else {
                maxLengths.removeObject(forKey: self)
            }
        }
    }

    ///
    @objc private func limitLength(_ textField: UITextField) {
        guard let maxLength = maxLength, let prospectiveText = textField.text, prospectiveText.count > maxLength else {
            return
        }
        let selection = selectedTextRange
        text = String(prospectiveText[..<prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)])
        selectedTextRange = selection
    }
}
