//
//  ApplicationController.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 19/09/22.
//

import Foundation

class SnapShotsController {
    
    private let applicationView: SnapShotsViewProtocol
    init(applicationView: SnapShotsViewProtocol) {
        SQLiteDatabase.shared.getDatabaseReady()
        self.applicationView = applicationView
    }
    
    func executeSnapShots() {
        
        while true {
            applicationView.displayMainPage()
            
            let mainPageOperationChoice = applicationView.getMainPageOperationsChoice()
            
            guard let mainPageOperation = SnapShotsNavigation(rawValue: mainPageOperationChoice) else {
                applicationView.displayImproperInputStatus()
                continue
            }

            switch mainPageOperation {
                case SnapShotsNavigation.signUp:
                    AppNavigator.moveTo(destination: .signUp)

                case SnapShotsNavigation.login:
                    AppNavigator.moveTo(destination: .login)

                case SnapShotsNavigation.forgotPassword:
                    AppNavigator.moveTo(destination: .forgotPassword)

                case SnapShotsNavigation.exit:
                    applicationView.displayInformationToUser(details: "Exiting")
                    SQLiteDatabase.shared.closeConnection()
                    exit(1)
            }
        }
    }
}



