//
//  SettingsView.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 16/08/22.
//

import Foundation

class SettingsView: BaseView,SettingsViewProtocol {
    
    func updateSettings() -> String  {
        while true {
            print("\n---------- SETTINGS ----------")
            for settingsOptions in Settings.allCases {
                print("\(settingsOptions.rawValue). \(settingsOptions)")
            }
            print("------------------------------")
            print("(Press '\\' to go back)\n")
            guard let settingsOption = readLine() else {
                displayImproperInputStatus()
                continue
            }
            
            return settingsOption
        }
    }

    func updateUserDetailsConfirmation(user: User) -> Bool {
        while true {
            print("\n-------------------------------------------")
            print("*** USER DETAILS ***")
            print("USERNAME: \(user.userName)")
            print("PHONE NUMBER: \(user.phoneNumber)")
            print("PASSWORD: \(user.password)")
            print("MAIL: \(user.mail)")
            print("GENDER: \(user.gender)")
            print("AGE: \(user.age)")
            print("--------------------------------------------\n")

            print("UPDATE DETAILS? YES(y) NO(n)")
            guard let updateAttribute = readLine(),
                  let isAffirmative = ConfirmationUtils.isAffirmativeChoice(userInput: updateAttribute) else {
                displayImproperInputStatus()
                continue
            }
                        
            return isAffirmative
        }
    }

    // USER'S CHOICE TO EDIT PROFILE
    func getChoiceOfAccountUpdate() -> String {
        while true {
            print("\nWhich one you want to update?")
            for accountAttribute in Account.allCases {
                print("\(accountAttribute.rawValue). \(accountAttribute)")
            }
            print("(Press '\\' to go back)\n")

            guard let accountAttribute = readLine() else {
                displayImproperInputStatus()
                continue
            }

            return accountAttribute
        }
    }
    
    func confirmAccountDeletion() -> Bool {
        while true {
            print("Delete for sure? YES(y) NO(n)")
            guard let isDeleteConfirmed = readLine(),
                  let isAffirmative = ConfirmationUtils.isAffirmativeChoice(userInput: isDeleteConfirmed) else {
                continue
            }
            
            return isAffirmative
        }
    }

    func displaySystemGeneratedOTP(systemOTP: Int) {
        print("An OTP has been sent to the number registered to this account.Enter the OTP to proceed.")
        print("OTP in Phone: \(systemOTP)")
    }

    func getOTPFromRegisterdNumber() -> String {
        while true {
            print("Enter the OTP: (Enter '\\' to abort)")
            
            guard let otpFromUser = readLine() else {
                continue
            }
            
            return otpFromUser
        }
    }
}



