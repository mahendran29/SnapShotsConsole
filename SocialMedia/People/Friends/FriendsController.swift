//
//  FriendsController.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 17/08/22.
//

import Foundation

class FriendsController {

    private let friendsView: FriendsViewProtocol
    private lazy var userDaoImp: UserDao = UserDaoImplementation(sqliteDatabase: SQLiteDatabase.shared)
    private lazy var friendsDaoImplementation: FriendsDao = FriendsDaoImplementation(sqliteDatabase: SQLiteDatabase.shared, userDaoImplementation: userDaoImp)
    private lazy var friendRequestDaoImplementation: FriendRequestDao = FriendRequestDaoImplementation(sqliteDatabase: SQLiteDatabase.shared, userDaoImplementation: userDaoImp)
    
    init(friendsView: FriendsViewProtocol) {
        self.friendsView = friendsView
    }
    
    func showFriendsOperations(userID: Int) {
        while true {
            let friendsOperationChoice = friendsView.getFriendsOperationsOptions()
        
            if Helper.isProcessAborted(userInput: friendsOperationChoice) {
                break
            }
            
            guard let friendsOperationChoice = Int(friendsOperationChoice),
                  let operationToPerform = Friend(rawValue: friendsOperationChoice) else {
                friendsView.displayImproperInputStatus()
                        continue
            }
            
            switch operationToPerform {
                case Friend.friendsList:
                    getMyFriends(userID: userID)
                case Friend.friendRequestList:
                    getFriendsRequest(userID: userID)
            }
        }
    }

    // MY FRIENDS
    private func getMyFriends(userID: Int) {
        
        let myFriendsNames: [String] = friendsDaoImplementation.getUserFriends(userID: userID)
                
        if myFriendsNames.isEmpty {
            friendsView.displayInformationToUser(details: "You have 0 friends at the moment. Send request to people to connect.")
            return
        }
        
        friendsView.displayMyFriends(myFriends: myFriendsNames)
    }

    // FRIEND REQUESTS
    private func getFriendsRequest(userID: Int) {
    
        while true {
                    
            let requestedFriendDetails: [(userId: Int, userName: String)] = friendRequestDaoImplementation.getRequestedFriendsList(userID: userID)
 
            if requestedFriendDetails.isEmpty {
                friendsView.displayInformationToUser(details: "You have 0 friend requests at the moment.")
                return
            }
                    
            friendsView.displayRequestedFriends(requestedFriends: requestedFriendDetails)

            let requestFriendOperationChoice = friendsView.getRequestFriendsOperationChoice()
            if Helper.isProcessAborted(userInput: requestFriendOperationChoice) {
                break
            }
            
            guard let requestFriendOperationChoice = Int(requestFriendOperationChoice),
                  let requestFriendOperation = FriendRequest(rawValue: requestFriendOperationChoice) else {
                friendsView.displayImproperInputStatus()
                        return
            }

            switch requestFriendOperation {
                case FriendRequest.accept:
                    approveFriendRequest(loggedInUser: userID, requestedFriends: requestedFriendDetails)
                case FriendRequest.reject:
                    rejectFriendRequest(loggedInUser: userID, requestedFriends: requestedFriendDetails)
            }
        }
    }

    // APPROVAL OF FRIEND REQUEST
    private func approveFriendRequest(loggedInUser: Int, requestedFriends: [(userId: Int, userName: String)]) {
        while true {
            let acceptingUser = friendsView.getAcceptingUser()

            guard let acceptingUser = inputValidation(requestedFriendsCount: requestedFriends.count, userInput: acceptingUser) else {
                return
            }

            acceptUserRequest(loggedInUser: loggedInUser, userID: requestedFriends[acceptingUser - 1].userId)
            break
        }
    }
    
    // ADDING THE ACCEPTED USER TO USER'S FRIENDS LIST
    private func acceptUserRequest(loggedInUser: Int, userID: Int) {
                
        if friendRequestDaoImplementation.acceptFriendRequest(loggedUserID: loggedInUser, friendRequestedUser: userID) &&
            removeUserRequest(loggedInUser: loggedInUser, userID: userID) {
            
            friendsView.displayInformationToUser(details: "Friend Request Accepted")
        } else {
            friendsView.displayInformationToUser(details: "Couldn't accept Friend Request. Try again later!")
        }
    }

    // DENIAL OF FRIEND REQUEST
    private func rejectFriendRequest(loggedInUser: Int, requestedFriends: [(userId: Int, userName: String)]) {
        while true {
            let rejectingUser = friendsView.getRejectingUser()

            guard let rejectingUser = inputValidation(requestedFriendsCount: requestedFriends.count, userInput: rejectingUser) else {
                return
            }

            if removeUserRequest(loggedInUser: loggedInUser, userID: requestedFriends[rejectingUser - 1].userId) {
                friendsView.displayInformationToUser(details: "Friend Request Rejected")
            } else {
                friendsView.displayInformationToUser(details: "Couldn't reject the friend request. Try again later!")
            }
            break
        }
    }

    // REMOVING THE USER'S REQUEST FROM REQUESTED FRIENDS LIST
    private func removeUserRequest(loggedInUser: Int, userID: Int) -> Bool {
        friendRequestDaoImplementation.removeFriendRequest(loggedUserID: loggedInUser, userID: userID)
    }

    // VALIDATION OF INPUT
    private func inputValidation(requestedFriendsCount: Int, userInput: String) -> Int? {
    
        if Helper.isProcessAborted(userInput: userInput) {
            return nil
        }

        guard let userInput = Int(userInput) else {
            friendsView.displayImproperInputStatus()
            return nil
        }

        if (userInput < 1 || userInput > requestedFriendsCount) {
            friendsView.displayImproperInputStatus()
            return nil
        }

        return userInput
    }
}
