//
//  SettingsViewProtocol.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 23/08/22.
//

import Foundation

protocol SettingsViewProtocol: BaseProtocol {
    func updateSettings() -> String 
    func updateUserDetailsConfirmation(user: User) -> Bool
    func getChoiceOfAccountUpdate() -> String
    func confirmAccountDeletion() -> Bool
    func displaySystemGeneratedOTP(systemOTP: Int)
    func getOTPFromRegisterdNumber() -> String
}
