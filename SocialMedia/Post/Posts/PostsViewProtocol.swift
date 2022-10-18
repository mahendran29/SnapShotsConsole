//
//  PostsViewProtocol.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 23/08/22.
//

import Foundation

protocol PostsViewProtocol: BaseProtocol {
    func getPostOptions() -> String
    func getCaptionFromUser() -> String
    func displayAllPosts(posts: [(postID: Int, postDetails: Post)])
    func isViewingParticularPost() -> Bool
    func getPostFromUser() -> String
    func getPostOperation(isPostOwner: Bool) -> String
    func getEditedCaption() -> String
    func getComments() -> String
    func getCommentOptions() -> String
    func getPostDeletionConfirmation() -> Bool
    func displayPost(postNumber: Int, post: Post)
    func displayAllLikedUsers(likedUsers: [String])
    func displayAllComments(allComments: [(username: String,comment: String)])
    func continueWith() -> Bool
}
