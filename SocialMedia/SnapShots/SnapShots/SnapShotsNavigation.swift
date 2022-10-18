//
//  HomePage.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 11/08/22.
//

import Foundation

enum SnapShotsNavigation: Int, CaseIterable, CustomStringConvertible {
    case signUp = 1
    case login
    case forgotPassword
    case exit
    
    var description: String {
        switch self {
        case .signUp: return "NEW TO SNAPSHOTS? SIGN-UP 🆕"
        case .login: return "ALREADY HAVE AN ACCOUNT? LOGIN 🆒"
        case .forgotPassword: return "FORGOT PASSWORD? GET HELP LOGGING IN 📵"
        case .exit: return "EXIT ❌"
        }
    }
}
