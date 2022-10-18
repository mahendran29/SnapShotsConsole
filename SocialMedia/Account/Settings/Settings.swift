//
//  Settings.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 16/08/22.
//

import Foundation

enum Settings: Int, CaseIterable, CustomStringConvertible {
    case account = 1
    case deleteAccount

    var description: String {
        switch self {
        case .account: return "ACCOUNT 🆒"
        case .deleteAccount: return "DELETE ACCOUNT 👎❌"
        }
    }
}
