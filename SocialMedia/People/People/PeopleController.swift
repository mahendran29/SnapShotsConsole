//
//  PeopleController.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 12/08/22.
//

import Foundation

class PeopleController {
    
    private let peopleView: PeopleViewProtocol
    private lazy var userDaoImp: UserDao = UserDaoImplementation(sqliteDatabase: SQLiteDatabase.shared)
    private lazy var friendsDaoImp: FriendsDao = FriendsDaoImplementation(sqliteDatabase: SQLiteDatabase.shared, userDaoImplementation: userDaoImp)
    private lazy var friendRequestDao: FriendRequestDao = FriendRequestDaoImplementation(sqliteDatabase: SQLiteDatabase.shared, userDaoImplementation: userDaoImp)

    init(peopleView: PeopleViewProtocol) {
        self.peopleView = peopleView
    }

    // SEARCH USER
    func showPeopleTab(loggedUserID: Int) {
        while true {
            let username = peopleView.getUserName()

            if Helper.isProcessAborted(userInput: username) {
                return
            }
            
            if Helper.checkMinimumUserNameLength(username: username) {
                peopleView.displayInformationToUser(details: "Give minimum of 3 characters! ⚠️")
                continue
            }
            
            let searchedUsersDetails = userDaoImp.getUserBasedOnSearch(userName: username)
            
            if searchedUsersDetails.isEmpty {
                peopleView.displayInformationToUser(details: "NO SEARCH FOUND! ❌ \n CONTINUE SEARCH? YES(y) NO(n)")
                
                if peopleView.isSearchContinue() {
                    continue
                }
                return
            }

            getUsers(loggedUserID: loggedUserID, searchedUsersDetails: searchedUsersDetails)
            break
        }
    }

    // GETTING ALL ACCOUNTS THAT USER HAS SEARCHED
    private func getUsers(loggedUserID: Int,searchedUsersDetails :[(userID: Int, userName: String)]) {
            
        while true {
            peopleView.displayAllAccounts(allUsers: searchedUsersDetails)

            let accountSelected = peopleView.getSelectedAccount()
            if Helper.isProcessAborted(userInput: accountSelected) {
                return
            }
            
            guard let accountSelected = Int(accountSelected) else {
                peopleView.displayImproperInputStatus()
                continue
            }

            if accountSelected <= 0 || accountSelected > searchedUsersDetails.count {
                peopleView.displayImproperInputStatus()
                continue
            }

            getOneParticularUser(loggedUserID: loggedUserID, userIDToGet: searchedUsersDetails[accountSelected - 1].userID )
        }
    }

    // GETTING ONE PARTICULAR ACCOUNT WHICH USER HAS SELECTED
    private func getOneParticularUser(loggedUserID: Int, userIDToGet: Int) {
    
        guard let user = userDaoImp.getUserDetails(userID: userIDToGet) else {
            return
        }
        
        if friendsDaoImp.isUserFriends(loggedUserID: loggedUserID, visitingUserID: userIDToGet) || loggedUserID == userIDToGet {
            showUserProfile(loggedUserID: loggedUserID, visitingUser: user, isFriend: true)
            return
        }
       showUserProfile(loggedUserID: loggedUserID, visitingUser: user)
    }

    // SHOW USER PROFILE
    private func showUserProfile(loggedUserID: Int, visitingUser: User, isFriend: Bool = false) {
        
        peopleView.displayProfileDetails(user: visitingUser)
        if isFriend {
            AppNavigator.moveTo(destination: .post, args: ["user": loggedUserID,"visitor":visitingUser.userID])
        } else {
            
            if friendRequestDao.isAlreadyRequestedFriend(loggedUserID: loggedUserID, visitingUserID: visitingUser.userID) {
                cancelFriendRequest(loggedUserID: loggedUserID)
            } else {
                sendingFriendRequest(loggedUserID: loggedUserID, visitingUser: visitingUser)
            }
        }
    }
    
    // FRIEND REQUEST TO ANOTHER USER
    private func sendingFriendRequest(loggedUserID: Int, visitingUser: User)  {
        if !peopleView.getFriendRequestAcceptConfirmation() {
            return
        }

        if friendRequestDao.sendFriendRequest(loggedUserID: loggedUserID, visitingUserID: visitingUser.userID) {
            visitingUser.profile.friendRequest.insert(loggedUserID)
            peopleView.displayInformationToUser(details: "Friend Request Sent to \(visitingUser.userName)!")
        } else {
            peopleView.displayInformationToUser(details: "Could not send request.Try again later.")
        }

    }

    private func cancelFriendRequest(loggedUserID: Int) {
        
        if !peopleView.geFriendRequestDenialConfirmation() {
            return
        }
        
        if friendRequestDao.cancelFriendRequest(loggedUserID: loggedUserID) {
            peopleView.displayInformationToUser(details: "Friend Request cancelled!")
        } else {
            peopleView.displayInformationToUser(details: "Couldn't cancel friend request.Try again later.")
        }
    }
}
