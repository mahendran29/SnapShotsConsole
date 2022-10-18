//
//  PostsView.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 16/08/22.
//

import Foundation

class PostsView: BaseView,PostsViewProtocol {
  
    func getPostOptions() -> String {
        while true {
            for postOperation in PostPage.allCases {
                print("\(postOperation.rawValue). \(postOperation.description)")
            }
            print("(Press '\\' to go back)\n")
            guard let postOperation = readLine() else {
                displayImproperInputStatus()
                continue
            }
            
            return postOperation
        }
    }

    func getCaptionFromUser() -> String {
        while true {
        
            print("Add Caption: (Enter '\\' to abort)  ")
            guard let postCaption = readLine() else {
                displayImproperInputStatus()
                continue
            }
            
            if postCaption.isEmpty {
                print("\nCannot be empty.\n")
                continue
            }
            return postCaption
        }
    }

    func displayAllPosts(posts: [(postID: Int, postDetails: Post)]) {
        
        for (postNumber, post) in posts.enumerated() {
            displayPost(postNumber: postNumber + 1, post: post.postDetails)
        }
    }
    
    func isViewingParticularPost() -> Bool {
        while true {
            print("View a particular post? YES(y) NO(n)\n")

            guard let isViewingAPost = readLine(),
                  let isAffirmative = ConfirmationUtils.isAffirmativeChoice(userInput: isViewingAPost) else {
                displayImproperInputStatus()
                continue
            }
            
            return isAffirmative
        }
    }

    func getPostFromUser() -> String {
        while true {
            print("Which post to get? (Enter '\\' to abort)")
            let postCount = readLine()

            guard let postCount = postCount else {
                displayImproperInputStatus()
                continue
            }

            return postCount
        }
    }

    func getPostOperation(isPostOwner: Bool) -> String {
        while true {
            for postOperation in PostOperation.allCases {
                if !isPostOwner && (postOperation == .delete || postOperation == .editCaption) { continue }
                
                print("\(postOperation.rawValue). \(postOperation.description)")
            }
            
            print("(Press '\\' to go back)\n")

            guard let postOperation = readLine() else {
                displayImproperInputStatus()
                continue
            }
            return postOperation
        }
    }
    

    func getEditedCaption() -> String {
        while true {
            print("Enter the edited caption: (Enter '\\' to abort)")
            guard let editedCaption = readLine() else {
                displayImproperInputStatus()
                continue
            }
            
            return editedCaption
        }
    }

    func getComments() -> String {
        while true {
            print("Enter comment: (Enter '\\' to abort)")
            guard let comment = readLine() else {
                displayImproperInputStatus()
                continue
            }
            
            if comment.isEmpty {
                displayInformationToUser(details: "Cannot be empty")
                continue
            }
            return comment
        }
    }

    func getCommentOptions() -> String {
        while true {
            for commentOptions in CommentOperation.allCases {
                print("\(commentOptions.rawValue). \(commentOptions.description)")
            }
            print("(Press '\\' to go back)\n")


            guard let commentOption = readLine() else {
                continue
            }

            return commentOption
        }
    }

    func getPostDeletionConfirmation() -> Bool {
        
        while true {
            print("Do you want to delete? YES(y) NO(n)")
            guard let isDeletedConfirmed = readLine(),
                  let isAffirmative = ConfirmationUtils.isAffirmativeChoice(userInput: isDeletedConfirmed) else {
                continue
            }
            
            return isAffirmative
        }
    }

    func displayPost(postNumber: Int, post: Post) {
        print("\n--------------------")
        print("POST \(postNumber):")
        print("--------------------")
        print("PHOTO: \(post.photo) \nCAPTION: \(post.caption)")
        print("--------------------\n")
    }

    func displayAllLikedUsers(likedUsers: [String]) {
        print("\n---------ALL LIKED USERS---------")
        for (index, userName) in likedUsers.enumerated() {
            print("\(index + 1). \(userName)")
        }
        print("---------ALL LIKED USERS---------\n")
    }

    func displayAllComments(allComments: [(username: String,comment: String)]) {
        print("\n---------- COMMENTS ----------")
        for (userName, comment) in allComments {
            print("\(userName): \(comment)")
        }
        print("---------- COMMENTS ----------\n")
    }
    
    func continueWith() -> Bool {
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
