//
//  Result.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 19/09/22.
//

import Foundation


enum SnapShotsError: Error {
    case invalidInput
    case abort
    case empty
}

enum OTPActionError: Error {
    case invalidInput
    case maximumTryReached
}

enum PasswordActionError: Error {
    case empty
    case lessCharacters
    case abort
    case mismatch
}



