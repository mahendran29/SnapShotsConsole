//
//  FriendRequestDao.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 11/10/22.
//

import Foundation

protocol FriendRequestDao {
    func getRequestedFriendsList(userID: Int) -> [(userId: Int, userName: String)]
    func acceptFriendRequest(loggedUserID: Int,friendRequestedUser: Int) -> Bool
    func removeFriendRequest(loggedUserID: Int,userID: Int) -> Bool
    func sendFriendRequest(loggedUserID: Int,visitingUserID: Int) -> Bool
    func cancelFriendRequest(loggedUserID: Int) -> Bool
    func isAlreadyRequestedFriend(loggedUserID: Int,visitingUserID: Int) -> Bool
}
