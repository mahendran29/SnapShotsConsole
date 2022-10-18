//
//  Friends.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 17/08/22.
//

import Foundation

enum Friend: Int,CaseIterable,CustomStringConvertible {
    case friendRequestList = 1
    case friendsList
    
    var description: String {
        switch self {
        case .friendRequestList: return "ALL FRIEND REQUESTS"
        case .friendsList: return "MY FRIENDS"
        }
    }
}

enum FriendRequest: Int,CaseIterable,CustomStringConvertible {
    case accept = 1
    case reject
    
    var description: String {
        switch self {
        case .accept: return "ACCEPT FRIEND REQUEST ✅"
        case .reject: return "REJECT FRIEND REQUEST ❌"
        }
    }
}
