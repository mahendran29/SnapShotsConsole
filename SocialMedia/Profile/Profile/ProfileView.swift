//
//  ProfileView.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 12/08/22.
//

import Foundation

class ProfileView: BaseView,ProfileViewProtocol {
    
    // PROFILE PAGE OF THE APP
    func displayProfile()  {
        print("\n----------------------")
        for profileTab in ProfileNavigation.allCases {
            print("\(profileTab.rawValue). \(profileTab)")
        }
        print("----------------------\n")
        print("(Press '\\' to go back)")
    }
    
    func getProfileTabChoice() -> String {
        while true {
            guard let profileTabChoice = readLine() else {
                displayImproperInputStatus()
                continue
            }
            
            return profileTabChoice
        }
    }
}
