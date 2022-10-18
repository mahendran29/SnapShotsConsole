//
//  UserDao.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 10/10/22.
//

import Foundation

protocol UserDao {
    func isPhoneNumberAlreadyExist(phoneNumber: String) -> Bool
    func isUsernameAlreadyExist(username: String) -> Bool
    func isPhotoPresent(userID: Int) -> Bool
    
    func getUserDetails(phoneNumber: String,password: String) -> User?
    func getUserDetails(phoneNumber: String) -> User?
    func getUserDetails(userID: Int) -> User?
    func getUserID(phoneNumber: String,password: String) -> Int?
    
    func createNewUser(userName: String, password: String, phoneNumber: String, gender: Gender, age: Int, mail: String) -> Bool
    
    func updatePassword(password: String,userID: Int) -> Bool
    func updateUsername(username: String,userID: Int) -> Bool
    func updatePhoneNumber(phoneNumber: String,userID: Int) -> Bool
    func updateMail(mailID: String,userID: Int) -> Bool
    func updateGender(gender: String,userID: Int) -> Bool
    func updateAge(age: Int,userID: Int) -> Bool
    func updatePhoto(photo: Int,userID: Int) -> Bool
    func updateBio(profileBio: String,userID: Int) -> Bool
    
    func getUserBasedOnSearch(userName: String) -> [(userID: Int, userName: String)]
    func getUsername(userID: Int) -> String
    
    func deleteAccount(userID: Int) -> Bool
}
