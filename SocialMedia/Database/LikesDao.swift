//
//  LikesDao.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 11/10/22.
//

import Foundation

protocol LikesDao {
    func isPostAlreadyLiked(loggedUserID: Int,visitingUserID: Int,postID: Int) -> Bool
    func addLikeToThePost(loggedUserID: Int,visitingUserID: Int,postID: Int) -> Bool
    func getAllLikesOfPost(userID: Int,postID: Int) -> [String]
}
