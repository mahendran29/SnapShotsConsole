//
//  FriendsListView.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 16/08/22.
//

import Foundation

class FriendsView: BaseView,FriendsViewProtocol {

    // ALL FRIENDS OPERATION
    func getFriendsOperationsOptions() -> String {
        while true {
            for friendOperation in Friend.allCases {
                print("\(friendOperation.rawValue). \(friendOperation.description)")
            }
            print("(Press '\\' to go back)")

            guard let friendOperation = readLine() else {
                displayImproperInputStatus()
                continue
            }

            return friendOperation
        }
    }

    // DISPLAY ALL USER'S FRIENDS
    func displayMyFriends(myFriends: [String]) {
        print("\n------------ MY FRIENDS ------------")
        for (index, friend) in myFriends.enumerated() {
            print("\(index + 1).\(friend)")
        }
        print("------------------------------------\n")
    }

    // DISPLAY ALL REQUESTED FRIENDS
    func displayRequestedFriends(requestedFriends: [(userId: Int, userName: String)]){
    
        print("\n------------ MY FRIEND REQUESTS ------------")
        for (index, friend) in requestedFriends.enumerated() {
            print("\(index + 1).\(friend.userName)")
        }
        print("--------------------------------------------\n")

        for friendRequestOperation in FriendRequest.allCases {
            print("\(friendRequestOperation.rawValue). \(friendRequestOperation.description)")
        }
        print("(Press '\\' to go back)")
    }
    
    func getRequestFriendsOperationChoice() -> String {
        
        while true {
            guard let friendRequestChoice = readLine() else {
                displayImproperInputStatus()
                continue
            }
            return friendRequestChoice
        }
    }

    // ACCEPTING THE FRIEND REQUEST
    func getAcceptingUser() -> String {
        while true {
            print("Accepting Friend Request for? (Enter '\\' to abort)")
            guard let friendAccepted =  readLine() else {
                displayImproperInputStatus()
                continue
            }
            return friendAccepted
        }
    }

    // REJECTING THE FRIEND REQUEST
    func getRejectingUser() -> String {
        
        while true {
            print("Rejecting Friend Request for? Enter (Enter '\\' to abort)")
            guard let friendRejected =  readLine() else {
                displayImproperInputStatus()
                continue
            }
            return friendRejected
        }
    }
}
