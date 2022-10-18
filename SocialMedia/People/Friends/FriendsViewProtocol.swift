//
//  FriendListViewProtocol.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 23/08/22.
//

import Foundation

protocol FriendsViewProtocol: BaseProtocol {
    func getFriendsOperationsOptions() -> String
    func displayMyFriends(myFriends: [String])
    func displayRequestedFriends(requestedFriends: [(userId: Int, userName: String)])
    func getRequestFriendsOperationChoice() -> String
    func getAcceptingUser() -> String
    func getRejectingUser() -> String
}
