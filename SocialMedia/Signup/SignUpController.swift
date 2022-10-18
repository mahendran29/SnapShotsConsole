//
//  SignUpController.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 11/08/22.
//

import Foundation

class SignUpController {
    private let signUpView: SignUpViewProtocol
    private lazy var userDaoImp: UserDao = UserDaoImplementation(sqliteDatabase: SQLiteDatabase.shared)

    init(signUpView: SignUpViewProtocol) {
        self.signUpView = signUpView
    }

    // GETTING USER'S DETAILS
    func executeSignUpProcess() {
        // GETTING USER NAME
        let usernameDetails = getUserNameDetails()
        if usernameDetails == .failure(.abort) {
            return
        }

        // GETTING PHONE NUMBER
        let phoneNumberDetails = getPhoneNumberDetails()
        if phoneNumberDetails == .failure(.abort) {
            return
        }

        // GETTING GENDER
        let genderDetails = getGenderDetails()
        if genderDetails == .failure(.abort) {
            return
        }

        // GETTING AGE
        let ageDetails = getAgeDetails()
        if ageDetails == .failure(.abort) {
            return
        }

        // GETTING MAIL-ID
        let mailDetails = getMailDetails()
        if mailDetails == .failure(.abort) {
            return
        }

        // GETTING PASSWORD
        let passwordDetails = getPasswordDetails()
        if passwordDetails == .failure(.abort) {
            return
        }

        updateUserDetails(
            userName: try! usernameDetails.get(),
            password: try! passwordDetails.get(),
            phoneNumber: try! phoneNumberDetails.get(),
            gender: try! genderDetails.get(),
            age: try! ageDetails.get(),
            mail: try! mailDetails.get()
        )
    }

    private func getUserNameDetails() -> Result<String, SnapShotsError> {
        while true {
            let usernameDetails = Helper.getUserNameFromUser()

            if usernameDetails == .failure(.abort) {
                return .failure(.abort)
            } else if usernameDetails == .failure(.empty) {
                signUpView.displayInformationToUser(details: "Cannot be empty!")
                continue
            } else if usernameDetails == .failure(.invalidInput) {
                signUpView.displayImproperInputStatus()
                continue
            }

            let userName = try! usernameDetails.get()
            if Helper.checkMinimumUserNameLength(username: userName) {
                signUpView.displayInformationToUser(details: "The username should contain atleast 4 characters")
                continue
            }

            if userDaoImp.isUsernameAlreadyExist(username: userName){
                signUpView.displayInformationToUser(details: "User name already exists. Try another username")
                continue
            }

            return .success(userName)
        }
    }

    private func getPhoneNumberDetails() -> Result<String, SnapShotsError> {
        while true {
            let userPhoneNumberDetails = Helper.getPhoneNumberFromUser()

            if userPhoneNumberDetails == .failure(.abort) {
                return .failure(.abort)
            } else if userPhoneNumberDetails == .failure(.empty) {
                signUpView.displayInformationToUser(details: "Cannot be empty!")
                continue
            } else if userPhoneNumberDetails == .failure(.invalidInput) {
                signUpView.displayImproperInputStatus()
                continue
            }

            let phoneNumber = try! userPhoneNumberDetails.get()

            if userDaoImp.isPhoneNumberAlreadyExist(phoneNumber: phoneNumber) {
                signUpView.displayInformationToUser(details: "Oops!The phone number is already associated with some account.Try another phone number.")
                continue
            }

            return .success(phoneNumber)
        }
    }

    private func getGenderDetails() -> Result<Gender, SnapShotsError> {
        while true {
            let genderDetails = Helper.getGenderFromUser()

            if genderDetails == .failure(.abort) {
                return .failure(.abort)
            } else if genderDetails == .failure(.invalidInput) {
                signUpView.displayImproperInputStatus()
                continue
            } else if genderDetails == .failure(.empty) {
                signUpView.displayInformationToUser(details: "Cannot be empty!")
                continue
            }

            return .success(try! genderDetails.get())
        }
    }

    private func getAgeDetails() -> Result<Int, SnapShotsError> {
        while true {
            let userAgeDetails = Helper.getAgeFromUser()

            if userAgeDetails == .failure(.abort) {
                return .failure(.abort)
            } else if userAgeDetails == .failure(.empty) {
                signUpView.displayInformationToUser(details: "Cannot be empty!")
                continue
            } else if userAgeDetails == .failure(.invalidInput) {
                signUpView.displayImproperInputStatus()
                continue
            }

            return .success(try! userAgeDetails.get())
        }
    }

    private func getMailDetails() -> Result<String, SnapShotsError> {
        while true {
            let userMailDetails = Helper.getEmailFromUser()

            if userMailDetails == .failure(.abort) {
                return .failure(.abort)
            } else if userMailDetails == .failure(.invalidInput) {
                signUpView.displayImproperInputStatus()
                continue
            } else if userMailDetails == .failure(.empty) {
                signUpView.displayInformationToUser(details: "Cannot be empty!")
                continue
            }

            return .success(try! userMailDetails.get())
        }
    }

    private func getPasswordDetails() -> Result<String, SnapShotsError> {
        while true {
            switch Helper.getPassword() {
                case .success(let password):
                    return .success(password)
                case .failure(.mismatch):
                    signUpView.displayInformationToUser(details: "Oops!Password does not match!")
                case .failure(.empty):
                    signUpView.displayInformationToUser(details: "Cannot be empty")
                case .failure(.lessCharacters):
                    signUpView.displayInformationToUser(details: "Less Characters. Minimum of 4 characters")
                case .failure(.abort):
                    return .failure(.abort)
            }
        }
    }

    // UDPATING THE DB AFTER GETTING THE USER DETAILS
    private func updateUserDetails(userName: String, password: String, phoneNumber: String, gender: Gender, age: Int, mail: String) {

        if userDaoImp.createNewUser(userName: userName, password: password, phoneNumber: phoneNumber, gender: gender, age: age, mail: mail) {
            signUpView.displayUserDetails(userName: userName, password: password, phoneNumber: phoneNumber, gender: gender, age: age, mail: mail)
        } else {
            signUpView.displayInformationToUser(details: "Error in signing up! Try again.")
            return
        }

        let checkPasswordExistQuery = "SELECT * FROM User WHERE Phone = '\(phoneNumber)' AND Password = '\(password)'"

        let user = UserInstance.getUserInstance(dbQuery: checkPasswordExistQuery)

        AppNavigator.moveTo(destination: .homePage, args: ["user": user!])
    }
}
