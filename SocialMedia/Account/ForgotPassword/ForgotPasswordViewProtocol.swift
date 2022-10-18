//
//  File1.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 12/08/22.
//

import Foundation

protocol ForgotPasswordViewProtocol: BaseProtocol {
    func getOTPFromUser() -> String
    func displaySystemGeneratedOTP(generatedOTP: Int)
}
