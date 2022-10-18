//
//  ForgotPasswordView.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 12/08/22.
//

import Foundation

class ForgotPasswordView: BaseView,ForgotPasswordViewProtocol {
    
    // GET OTP FOR VERFIFICATION
    func getOTPFromUser() -> String {
        while true {
            print("Enter the received OTP: (Press '\\' to abort) 🔢")
            
            guard let userOTP = readLine() else {
                displayImproperInputStatus()
                continue
            }
            
            return userOTP
        }
    }

    // DISPLAY OTP GENERATED BY SYSTEM FOR VERIFICATION
    func displaySystemGeneratedOTP(generatedOTP: Int) {
        print("\n-----------------------------")
        print("GENERATED OTP: \(generatedOTP)")
        print("-------------------------------\n")
    }
}
