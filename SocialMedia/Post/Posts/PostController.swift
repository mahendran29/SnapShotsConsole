//
//  PostController.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 19/08/22.
//

import Foundation

class PostController {

    private let postView: PostsViewProtocol
    private lazy var userDaoImp: UserDao = UserDaoImplementation(sqliteDatabase: SQLiteDatabase.shared)
    private lazy var friendsDaoImplementation: FriendsDao = FriendsDaoImplementation(sqliteDatabase: SQLiteDatabase.shared, userDaoImplementation: userDaoImp)
    private lazy var postDaoImp: PostDao = PostDaoImplementation(sqliteDatabase: SQLiteDatabase.shared, friendsDaoImplementation: friendsDaoImplementation)

    init(postView: PostsViewProtocol) {
        self.postView = postView
    }
    
    func getPostOperation(loggedUserID: Int) {
        while true {
            
            let postOption = postView.getPostOptions()
            if Helper.isProcessAborted(userInput: postOption) {
                break
            }
            
            guard let postOption = Int(postOption),
                  let postOperation = PostPage(rawValue: postOption) else {
                postView.displayImproperInputStatus()
                continue
            }

            switch postOperation {
                case PostPage.newPost:
                    uploadNewPost(loggedUserID: loggedUserID)
                case PostPage.allPost:
                    getAllPosts(loggedUserID: loggedUserID, visitingUserID: loggedUserID)
            }
        }
    }

    // ADDING A NEW POST
    private func uploadNewPost(loggedUserID: Int) {
        
        let postCaption = postView.getCaptionFromUser()
        
        if Helper.isProcessAborted(userInput: postCaption) {
            return
        }
        
        let postID = getNewPostID(loggedUserID: loggedUserID)
    
        if postDaoImp.uploadPost(postID: postID, caption: postCaption, userID: loggedUserID) {
            postView.displayInformationToUser(details: "Post uploaded")
        } else {
            postView.displayInformationToUser(details: "Couldn't upload post.Try again later!")
        }
    }
    
    private func getNewPostID(loggedUserID: Int) -> Int {
        return postDaoImp.createNewPostID(userID: loggedUserID)
    }

    // RETRIEVING ALL EXISTING POSTS
    func getAllPosts(loggedUserID: Int, visitingUserID: Int,currentPost: Post? = nil) {
        
        if let currentPost = currentPost {
            postOperation(loggedUserID: loggedUserID, visitingUserID: visitingUserID, currentPost: currentPost)
            return
        }
        
        let allPosts: [(postID: Int, postDetails: Post)] = postDaoImp.getAllPosts(userID: visitingUserID)         
        if allPosts.isEmpty {
            postView.displayInformationToUser(details: "No Post exists! ❌ \nGo back? YES(y)")
            if postView.continueWith() {
                return
            }
           
            return
        }
         
        postView.displayAllPosts(posts: allPosts)
        if postView.isViewingParticularPost(){
            getSinglePost(loggedUserID: loggedUserID, visitingUserID: visitingUserID, posts: allPosts)
        }
    }


    // GETTING A SINGLE POST
    private func getSinglePost(loggedUserID: Int, visitingUserID: Int,posts:[(postID: Int, postDetails: Post)]) {
        
        while true {
            let postToGet = postView.getPostFromUser()

            if Helper.isProcessAborted(userInput: postToGet) {
                return
            }

            guard let postToGet = Int(postToGet) else {
                postView.displayImproperInputStatus()
                continue
            }

            if postToGet <= 0 || postToGet > posts.count {
                postView.displayImproperInputStatus()
                continue
            }
            
            let post = posts[postToGet-1].postDetails
            postView.displayPost(postNumber: postToGet, post: post)
            postOperation(loggedUserID: loggedUserID, visitingUserID: visitingUserID, currentPost: post)
        }
    }

    // OPERATIONS IN POST
    private func postOperation(loggedUserID: Int, visitingUserID: Int, currentPost: Post) {
        postOperationLoop: while true {
    
            let isPostOwner = loggedUserID == visitingUserID
            let postOperationChoice = postView.getPostOperation(isPostOwner: isPostOwner)

            if Helper.isProcessAborted(userInput: postOperationChoice) {
                break postOperationLoop
            }
            
            guard let postOperationChoice = Int(postOperationChoice),
                let postOperationToPerform = PostOperation(rawValue: postOperationChoice) else {
                postView.displayImproperInputStatus()
                        continue
            }
            
            if !isPostOwner && (postOperationToPerform == PostOperation.delete || postOperationToPerform == PostOperation.editCaption) {
                postView.displayImproperInputStatus()
                continue
            }
            
            switch postOperationToPerform {
                case PostOperation.like:
                    addLike(loggedUserID: loggedUserID,visitingUserID: visitingUserID, currentPost: currentPost)
                case PostOperation.allLikes:
                    getAllLikes(visitingUserID: visitingUserID, currentPost: currentPost)
                case PostOperation.comment:
                    commentOperation(loggedUserID: loggedUserID, visitingUserID: visitingUserID, currentPost: currentPost)
                case PostOperation.editCaption:
                    editCaption(loggedUserID: loggedUserID, currentPost: currentPost)
                case PostOperation.delete:
                    deleteOperation(loggedUserID: loggedUserID, currentPost: currentPost)
                    break postOperationLoop
            }
        }
    }

    // LIKING A POST
    private func addLike(loggedUserID: Int,visitingUserID: Int, currentPost: Post) {
        
        let likesDaoImp: LikesDao = LikesDaoImplementation(sqliteDatabase: SQLiteDatabase.shared, userDaoImp: userDaoImp)

        if likesDaoImp.isPostAlreadyLiked(loggedUserID: loggedUserID, visitingUserID: visitingUserID, postID: currentPost.postID) {
            postView.displayInformationToUser(details: "Already liked")
            return
        }
                    
        if likesDaoImp.addLikeToThePost(loggedUserID: loggedUserID, visitingUserID: visitingUserID, postID: currentPost.postID) {
            postView.displayInformationToUser(details: "Liked!")
        }
    }

    private func getAllLikes(visitingUserID: Int,currentPost: Post) {
        
        let likesDaoImp: LikesDao = LikesDaoImplementation(sqliteDatabase: SQLiteDatabase.shared, userDaoImp: userDaoImp)

        let likedUsers: [String] = likesDaoImp.getAllLikesOfPost(userID: visitingUserID, postID: currentPost.postID)
        if likedUsers.isEmpty {
            postView.displayInformationToUser(details: "No one has liked the post yet! Be the first!")
            return
        }
        postView.displayAllLikedUsers(likedUsers: likedUsers)
    }

    // COMMMENTING ON A POST
    private func commentOperation(loggedUserID: Int,visitingUserID: Int, currentPost: Post) {
        let commentChoice = postView.getCommentOptions()

        if Helper.isProcessAborted(userInput: commentChoice) {
            return
        }
        
        guard let commentChoice = Int(commentChoice),
            let operationToPerform = CommentOperation(rawValue: commentChoice) else {
            postView.displayImproperInputStatus()
                    return
        }

        switch operationToPerform {
            case CommentOperation.addComment:
                addComment(loggedUserID: loggedUserID, visitingUserID: visitingUserID, currentPost: currentPost)
            case CommentOperation.viewComment:
                getAllComments(loggedUserID: visitingUserID)
        }
    }

    // ADD COMMENT TO A POST
    private func addComment(loggedUserID: Int,visitingUserID: Int, currentPost: Post){
        
        let commentsDaoImp: CommentDao = CommentDaoImplementation(sqliteDatabase: SQLiteDatabase.shared)
        
        let comment = postView.getComments()
        if Helper.isProcessAborted(userInput: comment) {
            return
        }
        
        if commentsDaoImp.addCommentToThePost(visitingUserID: visitingUserID, postID: currentPost.postID, comment: comment, loggedUserID: loggedUserID) {
            postView.displayInformationToUser(details: "Commented")
        } else {
            postView.displayInformationToUser(details: "Unable to add comment. Try later!")
        }
    }
    
    private func getAllComments(loggedUserID: Int) {
        
        let commentsDaoImp: CommentDao = CommentDaoImplementation(sqliteDatabase: SQLiteDatabase.shared)

        let comments: [(username: String,comment: String)] = commentsDaoImp.getAllCommmentsOfPost(loggedUserID: loggedUserID)
        if comments.isEmpty {
            postView.displayInformationToUser(details: "No comments yet")
            return
        }
        
        postView.displayAllComments(allComments: comments)
    }

    // EDITING CAPTION
    private func editCaption(loggedUserID: Int,currentPost: Post) {
        
        let newCaption = postView.getEditedCaption()
        if Helper.isProcessAborted(userInput: newCaption) {
            return
        }
    
        if postDaoImp.editCaptionInPost(caption: newCaption, userID: loggedUserID, postID: currentPost.postID) {
            postView.displayInformationToUser(details: "Caption changed")
        } else {
            postView.displayInformationToUser(details: "Unable to change caption. Try later!")
        }
    }

    // DELETING A POST
    private func deleteOperation(loggedUserID: Int, currentPost: Post) {
        while true {
            if !postView.getPostDeletionConfirmation() {
                return
            }
            if postDaoImp.deletePost(userID: loggedUserID, postID: currentPost.postID) {
                postView.displayInformationToUser(details: "Deletion successfull")
                break
            } else {
                postView.displayInformationToUser(details: "Could not delete. Try again!")
            }
        }
    }
}
