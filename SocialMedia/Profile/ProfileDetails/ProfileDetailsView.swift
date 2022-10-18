//
//  ProfileDetailsView.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 16/08/22.
//

import Foundation

class ProfileDetailsView: BaseView,ProfileDetailsViewProtocol {

    // DISPLAYING PROFILE DETAILS
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
    
    func getProfileUpdateConfirmation() -> Bool {
        while true {
            print("UPDATE DETAILS? YES(y) NO(n)")
            guard let updateDetailsConfirmation = readLine(),
                  let isAffirmative = ConfirmationUtils.isAffirmativeChoice(userInput: updateDetailsConfirmation) else {
                displayImproperInputStatus()
                continue
            }
            
            return isAffirmative 
        }
    }
    

    // GETTING THE USER'S OPTION WHICH ONE TO UPDATE
    func getUpdateProfileDetailsChoices() -> String {
        while true {
            print("\nWhich one you want to update?")
            for detail in ProfileDetails.allCases {
                print("\(detail.rawValue). \(detail.description)")
            }
            
            print("(Press '\\' to go back)\n")
            guard let userChoice = readLine() else {
                displayImproperInputStatus()
                continue
            }
            return userChoice
        }
    }
    
    // GET PHOTO FROM THE USER
    func getPhotoFromUser() -> String {
        
        while true {
            print("\nDo you want to upload/remove a photo?")
            for photo in Photo.allCases {
                print("\(photo.rawValue). \(photo)")
            }
            print("(Press '\\' to go back)\n")
            guard let photoUploadChoice = readLine() else {
                displayImproperInputStatus()
                continue
            }
            return photoUploadChoice
        }
    }

    // GET BIO FROM USER
    func getBioFromUser() -> String {
        while true {
            print("Enter your bio: (Enter '\\' to abort) ")
            guard let profileBio = readLine() else {
                displayImproperInputStatus()
                continue
            }
            return profileBio
        }
    }
}
