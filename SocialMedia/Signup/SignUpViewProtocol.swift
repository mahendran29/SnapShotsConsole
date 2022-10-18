//
//  SignUpViewProtocol.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 05/10/22.
//

import Foundation

protocol SignUpViewProtocol: BaseProtocol {
    func displayUserDetails(userName: String, password: String, phoneNumber: String, gender: Gender, age: Int, mail: String)
}
