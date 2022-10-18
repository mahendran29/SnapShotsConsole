//
//  ProfileController.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 19/09/22.
//

import Foundation

class ProfileController {
    
    private let profileView: ProfileViewProtocol
    
    init(profileView: ProfileViewProtocol) {
        self.profileView = profileView
    }
    
    func openProfileTab(userID: Int) {
        
        while true {
            
            profileView.displayProfile()
            let profileTabChoice = profileView.getProfileTabChoice()
            
            if Helper.isProcessAborted(userInput: profileTabChoice) {
                return
            }
            
            guard let profileTabChoice = Int(profileTabChoice),
                  let profileTab = ProfileNavigation(rawValue: profileTabChoice) else {
                profileView.displayImproperInputStatus()
                continue
            }
            
            switch profileTab {
                case .profileDetails:
                AppNavigator.moveTo(destination: .profileDetails, args: ["user": userID])

                case .posts:
                    AppNavigator.moveTo(destination: .post, args: ["user": userID])

                case .friends:
                    AppNavigator.moveTo(destination: .friends, args: ["user": userID])

                case .settings:
                    AppNavigator.moveTo(destination: .settings, args: ["user": userID])
                
                case .logout:
                    AppNavigator.moveTo(destination: .mainPage)
            }
        }
    }
}
