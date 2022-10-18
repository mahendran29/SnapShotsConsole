//
//  CommentDao.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 11/10/22.
//

import Foundation

protocol CommentDao {
    func getAllCommmentsOfPost(loggedUserID: Int) -> [(username: String,comment: String)]
    func addCommentToThePost(visitingUserID: Int,postID: Int,comment: String,loggedUserID: Int) -> Bool
}
