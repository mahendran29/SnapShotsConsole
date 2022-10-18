//
//  Helper.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 11/08/22.
//

import Foundation

class Helper {

    // GET USER NAME FROM THE USER
    static func getUserNameFromUser() ->  Result<String,SnapShotsError> {
        guard let username = fetchUserName() else {
            return .failure(.invalidInput)
        }

        if username.isEmpty {
            return .failure(.empty)
        }

        if isProcessAborted(userInput: username) {
            return .failure(.abort)
        }

        return .success(username)
    }

    // GET PHONE NUMBER FROM USER
    static func getPhoneNumberFromUser() -> Result<String,SnapShotsError> {
            
        guard let phoneNumber = fetchPhoneNumber() else {
            return .failure(.invalidInput)
        }

        if isProcessAborted(userInput: phoneNumber) {
            return .failure(.abort)
        }

        if !validatePhoneNumber(phoneNumber: phoneNumber) {
            return .failure(.invalidInput)
        }

        return .success(phoneNumber)
    }
    
    // GET GENDER FROM USER
    static func getGenderFromUser() -> Result<Gender,SnapShotsError> {
        guard let genderValue = fetchGender() else {
            return .failure(.invalidInput)
        }

        if isProcessAborted(userInput: genderValue) {
            return .failure(.abort)
        }

        guard let genderValue = Int(genderValue) else {
            return .failure(.invalidInput)
        }

        switch genderValue {
            case Gender.male.rawValue:
                return .success(Gender.male)
            case Gender.female.rawValue:
                return .success(Gender.female)
            default:
                return .failure(.invalidInput)
        }
    }

    // GET AGE FROM USER
    static func getAgeFromUser() -> Result<Int,SnapShotsError> {
    
        guard let age = fetchAge() else {
            return .failure(.invalidInput)
        }

        if isProcessAborted(userInput: age) {
            return .failure(.abort)
        }

        guard let age = Int(age) else {
            return .failure(.invalidInput)
        }

        if age < 0 || age > 100 {
            return .failure(.invalidInput)
        }

        return .success(age)
    }

    // GET EMAIL FROM USER
    static func getEmailFromUser() -> Result<String,SnapShotsError> {

        guard let mail = fetchMailID() else {
            return .failure(.invalidInput)
        }

        if isProcessAborted(userInput: mail) {
            return .failure(.abort)
        }

        if !isValidEmail(email: mail) {
            return .failure(.invalidInput)
        }

        return .success(mail)
    }

    static func getPassword() -> Result<String,PasswordActionError> {
        
        let password = fetchPasswordFromUser(value: "")
        if case Result.failure(let error) = password {
            return .failure(error)
        }
        
        let rePassword = fetchPasswordFromUser(value: "again")
        if case Result.failure(let error) = rePassword {
            if error == .abort {
                return .failure(.abort)
            } else {
                return .failure(.mismatch)
            }
        }

        if !checkPasswordMatch(password1: try! password.get(), password2: try! rePassword.get()) {
            return .failure(.mismatch)
        }
    
        return .success(try! password.get())
    }
    
    static func fetchPasswordFromUser(value: String) -> Result<String,PasswordActionError> {
        let MIN_PASSWORD_COUNT = 3

        while true {
            print("Enter \(value) password :     ( Enter '\\' to abort)")
            
            guard let password = readLine() else {
                continue
            }
            
            if password.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
                return .failure(.empty)
            }
            else if isProcessAborted(userInput: password) {
                return .failure(.abort)
            }
            else if password.count <= MIN_PASSWORD_COUNT {
                return .failure(.lessCharacters)
            }
            return .success(password)
        }
    }

    static func checkPasswordMatch(password1: String, password2: String) -> Bool {
        password1 == password2
    }

    // EXTRA VALIDATION FUNCTIONS
    static func validatePhoneNumber(phoneNumber: String) -> Bool {
        guard Int(phoneNumber) != nil else {
            return false
        }
        
        return phoneNumber.count == 10
    }

    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    static func generateOTP() -> Int {
        Int.random(in: 1000 ... 9999)
    }

    static func isProcessAborted(userInput: String) -> Bool {
        userInput.count == 1 && userInput.contains("\\")
    }
    
    static func checkMinimumUserNameLength(username: String) -> Bool {
        let MIN_USERNAME_LENGTH = 3
        return username.count < MIN_USERNAME_LENGTH
    }

    static func checkOTPMatch(systemOTP: Int,userOTP: String,otpTries: inout Int ) -> Result<Bool,OTPActionError> {
            if checkOTPTriesLimit(otpTries: &otpTries) {
                return .failure(.maximumTryReached)
            }
            
            guard let userOTP = Int(userOTP) else {
                return .failure(.invalidInput)
            }
            
            if isOTPMatching(generatedOTP: systemOTP, userOTP: userOTP) {
                return .success(true)
            } else {
                return .success(false)
            }
    }
    
    //  CHECKING OTP MATCH FOR DELETION
    static func isOTPMatching(generatedOTP: Int, userOTP: Int) -> Bool {
        generatedOTP == userOTP
    }
    
    // OTP FAILRE COUNT LIMIT
    static func checkOTPTriesLimit(otpTries: inout Int) -> Bool {
        let OTP_ATTEMPT_LIMIT = 2
        otpTries = otpTries + 1
        if otpTries > OTP_ATTEMPT_LIMIT {
            otpTries = 1
            return true
        }
        return false
    }
    
    // PHONE NUMBER FROM USER
    static func fetchPhoneNumber() -> String? {
        print("Enter your phone number: (Enter '\\' to abort)")
        return readLine()
    }
    
    // USER NAME FROM THE USER
    static func fetchUserName() -> String? {
        print("Enter your user name:  (Enter '\\' to abort)")
        return readLine()
    }

    // GENDER FROM THE USER
    static func fetchGender() -> String? {
        print("Choose your gender 1.MALE 2.FEMALE  ( Enter '\\' to abort)")
        return readLine()
    }

    // AGE FROM THE USER
    static func fetchAge() -> String? {
        print("Enter your age: (Maximum 100) (Enter '\\' to abort) ")
        return readLine()
    }

    // MAIL-ID FROM THE USER
    static func fetchMailID() -> String? {
        print("Enter your mail ID: (Enter '\\' to abort)")
        return readLine()
    }
}


