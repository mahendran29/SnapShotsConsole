//
//  SettingsController.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 16/08/22.
//

import Foundation

class SettingsController {
    
    private let settingsView: SettingsViewProtocol
    private lazy var userDaoImp: UserDao = UserDaoImplementation(sqliteDatabase: SQLiteDatabase.shared)
    
    init(settingsView: SettingsViewProtocol) {
        self.settingsView = settingsView
    }
    
    func openSettings(userID: Int) {
        
        while true {
            
            let updateSettingChoice = settingsView.updateSettings()
            
            if Helper.isProcessAborted(userInput: updateSettingChoice) {
                return
            }
            
            guard let updateSettingChoice = Int(updateSettingChoice),
                  let operationToPerform = Settings(rawValue: updateSettingChoice) else {
                settingsView.displayImproperInputStatus()
                        continue
            }
            
            guard let user = userDaoImp.getUserDetails(userID: userID) else {
                return
            }

            switch operationToPerform {
                case Settings.account:
                    updateAccountDetails(user: user)
                case Settings.deleteAccount:
                    if deletingAccount(user: user) {
                        AppNavigator.moveTo(destination: .mainPage)
                    }
            }
        }
    }
    
    // UPDATE ACCOUNT
    private func updateAccountDetails(user: User) {
        while true {
            
            if !settingsView.updateUserDetailsConfirmation(user: user) {
                break
            }
            
            let updateAccountChoice = settingsView.getChoiceOfAccountUpdate()

            if Helper.isProcessAborted(userInput: updateAccountChoice) {
                break
            }
                
            guard let updateAccountChoice = Int(updateAccountChoice),
                  let operationToPerform = Account(rawValue: updateAccountChoice) else {
                    settingsView.displayImproperInputStatus()
                            continue
            }

            switch operationToPerform {
                case Account.username:
                    changeUserName(user: user)
                case Account.phoneNumber:
                    changePhoneNumber(user: user)
                case Account.password:
                    changePassword(user: user)
                case Account.mail:
                    changeMail(user: user)
                case Account.gender:
                    changeGender(user: user)
                case Account.age:
                    changeAge(user: user)
            }
        }
    }

    // UPDATEING THE USER NAME
    private func changeUserName(user: User) {
        while true {
            let usernameDetails = Helper.getUserNameFromUser()
            
            if usernameDetails == .failure(.abort) {
                return
            } else if usernameDetails == .failure(.empty) {
                settingsView.displayInformationToUser(details: "Cannot be empty!")
                continue
            } else if usernameDetails == .failure(.invalidInput) {
                settingsView.displayImproperInputStatus()
                continue
            }
            
            let username = try! usernameDetails.get()
            if Helper.checkMinimumUserNameLength(username: username) {
                settingsView.displayInformationToUser(details: "The username should contain atleast 3 characters")
                continue
            }
            
            if userDaoImp.isUsernameAlreadyExist(username: username) {
                settingsView.displayInformationToUser(details: "User name already exists. Try another username")
                continue
            }
            
            if userDaoImp.updateUsername(username: username, userID: user.userID) {
                user.userName = username
                settingsView.displayInformationToUser(details: "Username changed successfully!")
                break
            } else {
                settingsView.displayInformationToUser(details: "Error in changing username! Try again")
            }
        }
    }

    // UPDATING THE PHONE NUMBER
    private func changePhoneNumber(user: User) {
        while true {
            let phoneNumberDetails = Helper.getPhoneNumberFromUser()

            if phoneNumberDetails == .failure(.abort) {
                return 
            } else if phoneNumberDetails == .failure(.empty) {
                settingsView.displayInformationToUser(details: "Cannot be empty!")
                continue
            } else if phoneNumberDetails == .failure(.invalidInput) {
                settingsView.displayImproperInputStatus()
                continue
            }
            
            let phoneNumber = try! phoneNumberDetails.get()
            if  userDaoImp.isPhoneNumberAlreadyExist(phoneNumber: phoneNumber){
                settingsView.displayInformationToUser(details: "Phone number already exists. Try another phone number")
                continue
            }
            
            if userDaoImp.updatePhoneNumber(phoneNumber: phoneNumber, userID: user.userID) {
                user.phoneNumber = phoneNumber
                settingsView.displayInformationToUser(details: "Phone number changed successfully!")
                break
            } else {
                settingsView.displayInformationToUser(details: "Error in changing Phone number! Try again")
            }
        }
    }

    // UPDATING THE PASSWORD
    private func changePassword(user: User) {
        while true {
            let oldPasswordDetails = Helper.fetchPasswordFromUser(value: "old")
            
            if oldPasswordDetails == .failure(.abort) {
                return
            } else if oldPasswordDetails == .failure(.empty) {
                settingsView.displayInformationToUser(details: "Cannot be empty")
                continue
            }

            if !Helper.checkPasswordMatch(password1: try! oldPasswordDetails.get(), password2: user.password) {
                settingsView.displayInformationToUser(details: "Oops!Password does not match!")
                continue
            }

            while true {
                switch Helper.getPassword() {
                    case .success(let password):

                        if userDaoImp.updatePassword(password: password, userID: user.userID) {
                            user.password = password
                            settingsView.displayInformationToUser(details: "Password changed successfully!")
                        } else {
                            settingsView.displayInformationToUser(details: "Error in changing password! Try again later!")
                        }
                        return
                    case .failure(.mismatch):
                        settingsView.displayInformationToUser(details: "Oops!Password does not match!")
                    case .failure(.empty):
                        settingsView.displayInformationToUser(details: "Cannot be empty")
                    case .failure(.lessCharacters):
                        settingsView.displayInformationToUser(details: "Less Characters. Minimum of 4 characters")
                    case .failure(.abort):
                        settingsView.displayInformationToUser(details: "Password change unsuccessfull!")
                        return
                }
            }
            break
        }
    }

    // UPDATING THE MAIL-ID
    private func changeMail(user: User) {
        while true {
            let mailDetails = Helper.getEmailFromUser()

            if mailDetails == .failure(.abort) {
                return
            } else if mailDetails == .failure(.invalidInput) {
                settingsView.displayImproperInputStatus()
                continue
            } else if mailDetails == .failure(.empty) {
                settingsView.displayInformationToUser(details: "Cannot be empty!")
                continue
            }
            
            if userDaoImp.updateMail(mailID: try! mailDetails.get(), userID: user.userID) {
                user.mail = try! mailDetails.get()
                settingsView.displayInformationToUser(details: "MAIL-ID changed successfully!")
                break
            } else {
                settingsView.displayInformationToUser(details: "Error in changing MAIL-ID! Try again")
            }
        }
    }

    // UPDATING THE GENDER
    private func changeGender(user: User) {
        
        while true {
            let genderDetails = Helper.getGenderFromUser()
            if genderDetails == .failure(.abort) {
                return
            } else if genderDetails == .failure(.invalidInput) {
                settingsView.displayImproperInputStatus()
                continue
            } else if genderDetails == .failure(.empty) {
                settingsView.displayInformationToUser(details: "Cannot be empty!")
                continue
            }
            
            if  userDaoImp.updateGender(gender: try! genderDetails.get().description, userID: user.userID){
                user.gender = try! genderDetails.get()
                settingsView.displayInformationToUser(details: "Gender changed successfully!")
                break
            } else {
                settingsView.displayInformationToUser(details: "Error in changing Gender! Try again")
            }
        }
    }

    // UPDATING THE AGE
    private func changeAge(user: User) {
        while true {
            let ageDetails = Helper.getAgeFromUser()
            
            if ageDetails == .failure(.abort) {
                return
            } else if ageDetails == .failure(.empty) {
                settingsView.displayInformationToUser(details: "Cannot be empty!")
                continue
            } else if ageDetails == .failure(.invalidInput) {
                settingsView.displayImproperInputStatus()
                continue
            }
            
            let age = try! ageDetails.get()
            if userDaoImp.updateAge(age: age, userID: user.userID) {
                user.age = age
                settingsView.displayInformationToUser(details: "Age changed successfully!")
                break
            } else {
                settingsView.displayInformationToUser(details: "Error in changing Gender! Try again")
            }
        }
    }

    // DELETE ACCOUNT METHODS
    private func deletingAccount(user: User) -> Bool {
        while true {
            if !settingsView.confirmAccountDeletion() {
                return false
            }
            return deleteAccount(user: user)
        }
    }

    // DELETING ACCOUNT
    private func deleteAccount(user: User) -> Bool {
        // OTP VALIDATION
        let systemGeneratedOTP = Helper.generateOTP()
        settingsView.displaySystemGeneratedOTP(systemOTP: systemGeneratedOTP)
        
        var otpTries = 0
        deleteAccountLoop: while true {
             
            let userOTP = settingsView.getOTPFromRegisterdNumber()
            if Helper.isProcessAborted(userInput: userOTP) {
                return false
            }
                
            let validOTPDetails = Helper.checkOTPMatch(systemOTP: systemGeneratedOTP, userOTP: userOTP, otpTries: &otpTries)
                
            switch validOTPDetails {
                case .success(true):
                    break deleteAccountLoop
                case .success(false):
                    settingsView.displayInformationToUser(details: "OTP does not match!")
                    continue
                case .failure(.maximumTryReached):
                    settingsView.displayInformationToUser(details: "You have failed 3 attempts. Try again!")
                    return false
                case .failure(.invalidInput):
                    settingsView.displayImproperInputStatus()
                    continue
            }
        }
        
        if userDaoImp.deleteAccount(userID: user.userID) {
            settingsView.displayInformationToUser(details: "Deleting Account...")
            return true
        } else {
            settingsView.displayInformationToUser(details: "Could not deleted Account. Try again later!")
            return false
        }
    }
}
