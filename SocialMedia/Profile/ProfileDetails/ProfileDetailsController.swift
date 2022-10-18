//
//  ProfileDetailsController.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 17/08/22.
//

import Foundation

class ProfileDetailsController{
    
    private let profileDetailsView: ProfileDetailsViewProtocol
    private lazy var userDaoImp: UserDao = UserDaoImplementation(sqliteDatabase: SQLiteDatabase.shared)

    init(profileDetailsView: ProfileDetailsViewProtocol) {
        self.profileDetailsView = profileDetailsView
    }
    
    func showProfileDetails(loggedUserID: Int) {
        
        while true {
            let getUserQuery = """
            SELECT * FROM User WHERE User_id = \(loggedUserID)
            """
            guard let user = UserInstance.getUserInstance(dbQuery: getUserQuery) else {
                profileDetailsView.displayImproperInputStatus()
                continue
            }
            profileDetailsView.displayProfileDetails(user: user)
         
            if profileDetailsView.getProfileUpdateConfirmation() {
                updateProfileDetails(user: user)
            } else {
                return
            }
        }
    }

    // UPDATING PROFILE DETAILS
    private func updateProfileDetails(user: User) {
        while true {
           
            let updateProfileDetailsChoice = profileDetailsView.getUpdateProfileDetailsChoices()

            if Helper.isProcessAborted(userInput: updateProfileDetailsChoice) {
                return
            }
            
            guard let updateProfileDetailsChoice = Int(updateProfileDetailsChoice),
                  let operationToPerform = ProfileDetails(rawValue: updateProfileDetailsChoice) else {
                profileDetailsView.displayImproperInputStatus()
                        return
            }

            switch operationToPerform {
                case ProfileDetails.photo:
                    changeProfilePhoto(user: user)
                case ProfileDetails.bio:
                    changeProfileBio(user: user)
            }
        }
    }

    // PROFILE PHOTO
    private func changeProfilePhoto(user: User) {
        while true {
            
            let photo = profileDetailsView.getPhotoFromUser()

            if Helper.isProcessAborted(userInput: photo) {
                return
            }
            
            guard let photo = Int(photo),
                  let operationToPerform = Photo(rawValue: photo) else {
                profileDetailsView.displayImproperInputStatus()
                        return
            }

            let isPhotoPresent = userDaoImp.isPhotoPresent(userID: user.userID)
            
            switch operationToPerform {
                case Photo.add:
                    if !isPhotoPresent {
                        addPhoto(user: user)
                    } else {
                        profileDetailsView.displayInformationToUser(details: "Photo already exist")
                    }
                
                case Photo.remove:
                    if isPhotoPresent {
                        removePhoto(user: user)
                    } else {
                        profileDetailsView.displayInformationToUser(details: "Photo does not exist")
                    }
            }
        }
    }
        
    private func addPhoto(user: User) {
        
        if userDaoImp.updatePhoto(photo: 1, userID: user.userID) {
            user.profile.photo = true
            profileDetailsView.displayInformationToUser(details: "Photo addded successfully!")
        } else {
            profileDetailsView.displayInformationToUser(details: "Error in changing Photo number! Try again")
        }
    }
    
    private func removePhoto(user: User) {
        
        if userDaoImp.updatePhoto(photo: 0, userID: user.userID) {
            user.profile.photo = false
            profileDetailsView.displayInformationToUser(details: "Photo removed successfully!")
        } else {
            profileDetailsView.displayInformationToUser(details: "Error in removing Photo number! Try again")
        }
    }

    // PROFILE BIO
    private func changeProfileBio(user: User) {
        
        while true {
            let userProfileBio = profileDetailsView.getBioFromUser()
            
            if userProfileBio.isEmpty {
                profileDetailsView.displayInformationToUser(details: "Bio cannot be empty.")
                continue
            }
            
            if Helper.isProcessAborted(userInput: userProfileBio) {
                return
            }
            
            if userDaoImp.updateBio(profileBio: userProfileBio, userID: user.userID){
                user.profile.bio = userProfileBio
                profileDetailsView.displayInformationToUser(details: "Bio changed successfully")
                return
            } else {
                profileDetailsView.displayInformationToUser(details: "Error in chaning bio")
            }
        }
    }
}
