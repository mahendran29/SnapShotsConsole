//
//  FeedsController.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 12/08/22.
//

import Foundation

class FeedsController {

    private let feedsView: FeedsViewProtocol
    private lazy var userDaoImp: UserDao = UserDaoImplementation(sqliteDatabase: SQLiteDatabase.shared)
    private lazy var friendsDaoImp: FriendsDao = FriendsDaoImplementation(sqliteDatabase: SQLiteDatabase.shared, userDaoImplementation: userDaoImp)
    private lazy var postDaoImp: PostDao = PostDaoImplementation(sqliteDatabase: SQLiteDatabase.shared, friendsDaoImplementation: friendsDaoImp)

    init(feedsView: FeedsViewProtocol) {
        self.feedsView = feedsView
    }

    // GET ALL POSTS TO DISPLAY IN FEED
    func showFeedsTab(userID: Int) {
        
        feedsView.displayInformationToUser(details: "-------------- FEEDS -------------")

        let feedPosts: [(userId: Int,userName: String,post: Post)] = postDaoImp.getAllFriendPosts(userID: userID)
        if feedPosts.isEmpty {
            feedsView.displayInformationToUser(details: "NO FEED AVAILABLE NOW!")
            return
        }
    
        feedsView.displayAllPosts(entireFeed: feedPosts)
    
        if feedsView.isViewingParticularPost() {
            performOperations(userID: userID, entireFeed: feedPosts)
        }
    }

    // OPERATION ON POST -> LIKES,COMMENT etc
    private func performOperations(userID: Int, entireFeed: [(userId: Int, userName: String, post: Post)]) {
    
        let postNumber = feedsView.getPostChoiceFromUser()
        
        if postNumber <= 0 || postNumber > entireFeed.count {
            feedsView.displayImproperInputStatus()
            return
        }
        
        let visitingUserID = entireFeed[postNumber - 1].userId
                
        AppNavigator.moveTo(destination: .post, args: ["user": userID,"visitor": visitingUserID,"post": entireFeed[postNumber - 1].post])
    }
}
