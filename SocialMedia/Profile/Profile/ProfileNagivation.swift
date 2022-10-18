//
//  Profile.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 16/08/22.
//

import Foundation

enum ProfileNavigation: Int, CaseIterable, CustomStringConvertible {
    case profileDetails = 1
    case posts
    case friends
    case settings
    case logout
    
    var description: String {
        switch self {
        case .profileDetails: return "PROFILE DETAILS"
        case .posts: return "POSTS"
        case .friends: return "FRIENDS"
        case .settings: return "SETTINGS ⚙️"
        case .logout: return "LOG OUT "
        }
    }
}
