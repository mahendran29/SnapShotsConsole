//
//  ConfirmationUtils.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 30/09/22.
//

import Foundation

struct ConfirmationUtils {
    private static let CHOICE_YES = "y"
    private static let CHOICE_NO = "n"
    
    static func isAffirmativeChoice(userInput: String) -> Bool? {
        
        if userInput == CHOICE_YES {
            return true
        } else if userInput == CHOICE_NO  {
            return false
        } else {
            return nil
        }
    }
}
