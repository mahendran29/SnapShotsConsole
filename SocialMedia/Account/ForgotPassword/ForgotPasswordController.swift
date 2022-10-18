//
//  ForgotPasswordController.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 12/08/22.
//

import Foundation

class ForgotPasswordController {
    private let forgotPasswordView: ForgotPasswordViewProtocol
    private lazy var userDaoImp: UserDao = UserDaoImplementation(sqliteDatabase: SQLiteDatabase.shared)
    
    init(forgotPasswordView: ForgotPasswordViewProtocol) {
        self.forgotPasswordView = forgotPasswordView
    }

    // RESETTING THE PASSWORD
    func executeForgotPasswordProcess() {
        while true {
            let phoneNumberDetails = getPhoneNumberDetails()
            if phoneNumberDetails == .failure(.abort) {
                return
            }
            
            guard let user = userDaoImp.getUserDetails(phoneNumber: try! phoneNumberDetails.get() ) else {
                forgotPasswordView.displayInformationToUser(details: "You are registered with this Phone Number.Register to contine...")
                return
            }

            if !isOTPVerified() {
                continue
            }

            changePassword(user: user)
            break
        }
    }

    private func getPhoneNumberDetails() -> Result<String, SnapShotsError> {
        while true {
            let phoneNumberDetails = Helper.getPhoneNumberFromUser()
        
            if phoneNumberDetails == .failure(.abort) {
                return .failure(.abort)
            } else if phoneNumberDetails == .failure(.invalidInput) {
                forgotPasswordView.displayImproperInputStatus()
                continue
            }
                                
            return .success(try! phoneNumberDetails.get())
        }
    }

    private func isOTPVerified() -> Bool {
        let systemGeneratedOTP = Helper.generateOTP()
        forgotPasswordView.displaySystemGeneratedOTP(generatedOTP: systemGeneratedOTP)
        
        var otpTries = 0
        while true {
            let userOTP = forgotPasswordView.getOTPFromUser()
            
            if Helper.isProcessAborted(userInput: userOTP) {
                return false
            }
            
            let validOTPDetails = Helper.checkOTPMatch(systemOTP: systemGeneratedOTP, userOTP: userOTP, otpTries: &otpTries)
            
            switch validOTPDetails {
                case .success(true):
                    return true
                case .success(false):
                    forgotPasswordView.displayInformationToUser(details: "OTP does not match!")
                    continue
                case .failure(.maximumTryReached):
                    forgotPasswordView.displayInformationToUser(details: "You have failed 3 attempts. Try again!")
                    return false
                case .failure(.invalidInput):
                    forgotPasswordView.displayImproperInputStatus()
                    continue
            }
        }
    }
    
    private func changePassword(user: User) {
        while true {
            switch Helper.getPassword() {
                case .success(let password):
                
                    if userDaoImp.updatePassword(password: password, userID: user.userID) {
                        forgotPasswordView.displayInformationToUser(details: "Password changed successfully!")
                    } else {
                        forgotPasswordView.displayInformationToUser(details: "Error in changing password! Try again later!")
                    }
                    
                    return
                case .failure(.mismatch):
                    forgotPasswordView.displayInformationToUser(details: "Oops!Password does not match!")
                    continue
                case .failure(.empty):
                    forgotPasswordView.displayInformationToUser(details: "Cannot be empty")
                    continue
                case .failure(.lessCharacters):
                    forgotPasswordView.displayInformationToUser(details: "Less Characters. Minimum of 4 characters")
                    continue
                case .failure(.abort):
                    forgotPasswordView.displayInformationToUser(details: "Password change unsuccessfull!")
                    return
            }
        }
    }
}
