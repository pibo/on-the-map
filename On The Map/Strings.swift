//
//  Strings.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 22/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

struct Strings {
    
    struct Error {
        static let title = "Error"
        static let message = "An error occurred. Please try again in a moment!"
    }
    
    struct InvalidCredentials {
        static let title = "Wrong Combination"
        static let message = "The provided crendentials are invalid. Please try again!"
    }
    
    struct RefreshFailed {
        static let title = "Couldn't Refresh"
        static let message = "An error occurred when refreshing. Please try again in a moment!"
    }
    
    struct SignOut {
        static let title = "Sign Out"
        static let message = "Are you sure you want to sign out? You have to provide an e-mail and password to sign in again."
    }
    
    struct NewStudentLocationOverwrite {
        static let title = "You Already Have a Link"
        static let message = "You already have posted a link previously. Would you like to overwrite your previous data? This cannot be undone."
    }
    
    struct NewStudentLocationNotFound {
        static let title = "Location Not Found"
        static func message(_ mapString: String) -> String {
            return "Couldn't find a location for \"\(mapString)\". Please try again with another string."
        }
    }
}
