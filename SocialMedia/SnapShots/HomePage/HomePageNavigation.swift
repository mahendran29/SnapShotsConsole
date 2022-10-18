//
//  HomePage.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 12/08/22.
//

import Foundation

enum HomepageNavigation: Int,CaseIterable,CustomStringConvertible {
    case feeds = 1
    case people
    case profile
    
    var description: String{
        switch self {
        case .feeds: return "FEEDS 📰"
        case .people: return "PEOPLE 🔎"
        case .profile: return "PROFILE 📸"
        }
    }
}
