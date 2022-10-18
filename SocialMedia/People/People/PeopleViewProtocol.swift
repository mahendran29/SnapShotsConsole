//
//  PeopleViewProtocol.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 23/08/22.
//

import Foundation

protocol PeopleViewProtocol: BaseProtocol {
    func getUserName() -> String
    func displayAllAccounts(allUsers: [(userID: Int, userName: String)])
    func getSelectedAccount() -> String
    func displayProfileDetails(user: User)
    func getFriendRequestAcceptConfirmation() -> Bool
    func geFriendRequestDenialConfirmation() -> Bool
    func isSearchContinue() -> Bool
}
