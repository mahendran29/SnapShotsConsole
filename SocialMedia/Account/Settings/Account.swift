//
//  Account.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 16/08/22.
//

import Foundation

enum Account: Int, CaseIterable,CustomStringConvertible {
    case username = 1
    case phoneNumber
    case password
    case mail
    case gender
    case age
    
    var description: String {
        switch self {
        case .username: return "USERNAME 🤩"
        case .phoneNumber: return "PHONE NUMBER 📱"
        case .password: return "PASSWORD "
        case .mail: return "MAIL-ID 📧"
        case .gender: return "GENDER 🚻"
        case .age: return "AGE 🔢"
        }
    }
}
