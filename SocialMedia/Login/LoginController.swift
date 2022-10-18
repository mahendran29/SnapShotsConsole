//
//  LoginController.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 11/08/22.
//

import Foundation
import SQLite3

class LoginController {
    private let loginView: LoginViewProtocol
    private lazy var userDaoImp: UserDao = UserDaoImplementation(sqliteDatabase: SQLiteDatabase.shared)

    init(loginView: LoginViewProtocol) {
        self.loginView = loginView
    }

    // GETTING USER'S CREDENTIALS TO LOGIN
    func executeLoginProcess() {
        while true {
            loginView.displayInformationToUser(details: "--------------------   LOG IN PAGE   -------------------")

            let phoneNumberDetails = Helper.getPhoneNumberFromUser()
            if phoneNumberDetails == .failure(.abort) {
                return
            } else if phoneNumberDetails == .failure(.invalidInput) {
                loginView.displayImproperInputStatus()
                continue
            }
            
            if !userDaoImp.isPhoneNumberAlreadyExist(phoneNumber: try! phoneNumberDetails.get()) {
                loginView.displayInformationToUser(details: "Not an user. Register")
                return
            }

            let passwordDetails = getPasswordDetails()
            if passwordDetails == .failure(.abort) {
                return
            }

            let userCredentialsValidation = isLoginCredentialsValid(
                phoneNumber: try! phoneNumberDetails.get(),
                password: try! passwordDetails.get()
            )

            switch userCredentialsValidation {
                case .success(nil):
                    continue
                case .success(let userID):
                    AppNavigator.moveTo(destination: .homePage, args: ["user": userID!])
                default:
                    loginView.displayImproperInputStatus()
            }
        }
    }

    private func getPasswordDetails() -> Result<String, PasswordActionError> {
        let userPassword = Helper.fetchPasswordFromUser(value: "")
        switch userPassword {
            case .failure(.abort):
                return .failure(.abort)
            case .success(let password):
                return .success(password)
            default:
                return .success("")
        }
    }

    private func isLoginCredentialsValid(phoneNumber: String, password: String) -> Result<Int?, SnapShotsError> {

        guard let userID = userDaoImp.getUserID(phoneNumber: phoneNumber, password: password)  else {
            loginView.displayInformationToUser(details: "Wrong credentials! Try again!")
            return .success(nil)
        }

        loginView.displayLoginSuccessMessage()
        return .success(userID)
    }
}
