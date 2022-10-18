//
//  Profile.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 12/08/22.
//

import Foundation

class Profile {
    var photo: Bool = false
    var bio: String = ""
    var friendRequest = Set<Int>()
    var friendsList = Set<Int>()
    var posts: [Int: Post] = [:]
}
