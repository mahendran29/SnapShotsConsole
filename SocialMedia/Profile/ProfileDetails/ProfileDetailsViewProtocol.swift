//
//  ProfileDetailsViewProtocol.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 23/08/22.
//

import Foundation

protocol ProfileDetailsViewProtocol: BaseProtocol {
    func getProfileUpdateConfirmation() -> Bool
    func displayProfileDetails(user: User)
    func getUpdateProfileDetailsChoices() -> String
    func getPhotoFromUser() -> String
    func getBioFromUser() -> String
}
