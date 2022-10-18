//
//  FeedsView.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 12/08/22.
//

import Foundation

class FeedsView: BaseView,FeedsViewProtocol {

    // DISPLAY ALL POSTS IN FEED
    func displayAllPosts(entireFeed: [(userId: Int, userName: String, post: Post)]) {
        for (number, post) in entireFeed.enumerated() {
            print("\n----------------------------------")
            print("POST NUMBER: \(number + 1)")
            print("----------------------------------")
            print("USERNAME: \(post.userName)")
            print("PHOTO: \(post.post.photo)")
            print("CAPTION: \(post.post.caption)")
            print("----------------------------------\n")
        }
    }
    
    func isViewingParticularPost() -> Bool {
        while true {
            print("View a particular post? YES(y) NO(n) \n")
        
            guard let userChoice = readLine(),
                  let isAffirmative = ConfirmationUtils.isAffirmativeChoice(userInput: userChoice) else {
                displayImproperInputStatus()
                continue
            }
            
            
            return isAffirmative
        }
    }
    
    func getPostChoiceFromUser() -> Int {
        while true {
            print("Which post to get? (Enter '\\' to abort)")
       
            guard let postNumberInString = readLine(),
                  let postNumber = Int(postNumberInString) else {
                displayImproperInputStatus()
                continue
            }

            return postNumber
        }
    }
}
