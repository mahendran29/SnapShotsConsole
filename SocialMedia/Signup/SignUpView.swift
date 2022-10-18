//
//  SignUpView.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 11/08/22.
//

import Foundation

class SignUpView: BaseView,SignUpViewProtocol {
    
    func displayUserDetails(userName: String, password: String, phoneNumber: String, gender: Gender, age: Int, mail: String) {
        print("-------------------------------------------------")
        print("         Account created successfully            ")
        print("-------------------------------------------------")
        print(" ***   USER DETAILS   ***")
        print(" USER NAME: \(userName)")
        print(" PASSWORD: \(password)")
        print(" PHONE NUMBER: \(phoneNumber)")
        print(" GENDER: \(gender)")
        print(" AGE: \(age)")
        print(" MAIL ID: \(mail)")
        print("-------------------------------------------------")
    }
}
