//
//  PeopleView.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 12/08/22.
//

import Foundation

class PeopleView: BaseView,PeopleViewProtocol {
    
    // SEARCHING FOR A USER
    func getUserName() -> String {
        while true {
            print("\n\n--------------------------------------------------------------------")
            print("*                        SEARCH FOR PEOPLE 🔎                      *")
            print("--------------------------------------------------------------------")
            print("Enter the username: (Minimum of 3 characters) (Enter '\\' to abort)")
            guard let userName = readLine() else {
                continue
            }
            print("--------------------------------------------------------------------")

            return userName
        }
    }

    // DISPLAYING ALL SEARCHED ACCOUNTS
    func displayAllAccounts(allUsers: [(userID: Int, userName: String)]) {
        print("\n-----------------------------------")
        print("\t  SEARCHED USERS RESULTS ")
        print("-----------------------------------")
        for (index, user) in allUsers.enumerated() {
            print("\(index + 1). \(user.userName)")
        }
        print("-----------------------------------\n")
    }
    
    // SHOWING ALL THE ACCOUNTS TO THE USER
    func getSelectedAccount() -> String {
        while true {
            print("\n------------------------------------------------------------")
            print("Select any user to view their profile. (Press '\\' to go back)")
            print("------------------------------------------------------------\n")

            guard let account = readLine() else {
                continue
            }
            return account
        }
    }
    
    func displayProfileDetails(user: User) {
        
        print("--------------- \(user.userName)'s PROFILE ----------------")
        print("  ***********                                ")
        print("  *         *          \(user.profile.posts.count)          \(user.profile.friendsList.count)          ")
        print("  *  \(user.profile.photo)  *        POSTS     FRIENDS       ")
        print("  *         *                                ")
        print("  ***********                                ")
        print("  NAME: \(user.userName)                            ")
        print("  BIO: \(user.profile.bio)                               \n")
    }
    
    func getFriendRequestAcceptConfirmation() -> Bool {
        while true {
            print("SEND FRIEND REQUEST? YES(y) NO(n)")

            guard let friendRequestAcceptanceConfirmation = readLine(),
                  let isAffirmative = ConfirmationUtils.isAffirmativeChoice(userInput: friendRequestAcceptanceConfirmation) else {
                displayImproperInputStatus()
                continue
            }
            
            return isAffirmative
        }
    }

    // VIEWING OTHER USER'S PROFILE
    func geFriendRequestDenialConfirmation() -> Bool {
        while true {
            print("CANCEL FRIEND REQUEST? YES(y) NO(n)")
            guard let friendRequestCancelConfirmation = readLine(),
                  let isAffirmative = ConfirmationUtils.isAffirmativeChoice(userInput: friendRequestCancelConfirmation) else {
                displayImproperInputStatus()
                continue
            }
            
            return isAffirmative
        }
    }
    
    func isSearchContinue() -> Bool {
        while true {
            guard let isSearchContinue = readLine(),
                  let isAffirmative = ConfirmationUtils.isAffirmativeChoice(userInput: isSearchContinue) else {
                displayImproperInputStatus()
                continue
            }
            
            return isAffirmative
        }
    }
}
