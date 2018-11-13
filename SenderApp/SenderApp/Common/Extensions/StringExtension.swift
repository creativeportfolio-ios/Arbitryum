//
//  StringExtension.swift
//  
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import Foundation

// MARK: - Extension for String Methods
extension String {

    /// Trim string from left & right side extra spaces.
    ///
    /// - Returns: final string after removing extra left & right space.
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }

    /// check string is numeric or not
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
