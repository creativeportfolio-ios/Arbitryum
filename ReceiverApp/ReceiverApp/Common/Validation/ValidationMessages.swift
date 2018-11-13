//
//  ValidationMessages.swift
//  
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

///
struct ValidationMessages {

    ///
    struct Common {
        static let empty = "Please enter %@"
    }
    
    ///
    struct Name {
        static let empty = "Please enter %@"
        static let notValid = "Please enter valid %@"
        static let minLength = "%@ should be minimum %d in length"
        static let maxLength = "%@ should be maximum %d in length"
    }

    ///
    struct Number {
        static let empty = "Please enter %@"
        static let notValid = "Please enter valid %@"
        static let minLength = "%@ should be minimum %d in length"
        static let maxLength = "%@ should be maximum %d in length"
    }

    ///
    struct color {
        static let empty = "Please enter %@"
    }

    ///
    struct flavor {
        static let empty = "Please enter %@"
    }

    ///
    struct weight {
        static let empty = "Please enter %@"
        static let minLength = "%@ should be minimum %d in length"
        static let maxLength = "%@ should be maximum %d in length"
    }

    ///
    struct temperature {
        static let empty = "Please enter %@"
        static let minLength = "%@ should be minimum %d in length"
        static let maxLength = "%@ should be maximum %d in length"
    }

}
