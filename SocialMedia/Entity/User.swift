//
//  User.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 11/08/22.
//

import Foundation

class User {
    var userID: Int
    var userName: String
    var password: String
    var phoneNumber: String
    var gender: Gender
    var age: Int
    var mail: String
    var profile: Profile
    
    init(userId: Int,userName: String, password: String, phoneNumber: String, gender: Gender, age: Int, mail: String,photo: Bool,bio: String) {
        
        self.userID = userId
        self.userName = userName
        self.password = password
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.age = age
        self.mail = mail
        profile = Profile()
        profile.photo = photo
        profile.bio = bio
    }
}

