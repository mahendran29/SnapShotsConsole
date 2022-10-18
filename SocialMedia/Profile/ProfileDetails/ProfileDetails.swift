//
//  ProfileDetails.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 17/08/22.
//

import Foundation

enum ProfileDetails: Int, CaseIterable, CustomStringConvertible {
    case photo = 1
    case bio

    var description: String {
        switch self {
        case .photo: return "Photo 📸"
        case .bio: return "Bio 🔠"
        }
    }
}

enum Photo: Int, CaseIterable, CustomStringConvertible {
    case add = 1
    case remove

    var description: String {
        switch self {
        case .add: return "Add ➕"
        case .remove: return "Remove ➖"
        }
    }
}
