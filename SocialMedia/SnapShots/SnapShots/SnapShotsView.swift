//
//  MainPageView.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 11/08/22.
//

import Foundation

class SnapShotsView: BaseView,SnapShotsViewProtocol {
        
    // DISPLAYING REGISTER/LOG-IN PAGE OF THE APP
    func displayMainPage() {
        print("-------------------------------------------------")
        print("***      SNAPSHOTS®     ***\n")
        for mainPageOperations in SnapShotsNavigation.allCases {
            print("\(mainPageOperations.rawValue). \(mainPageOperations.description)")
        }
        print("-------------------------------------------------")
    }
    
    func getMainPageOperationsChoice() -> Int {
        
        while true {
            print("Enter your choice: ", terminator: "")
            guard let mainPageOperationChoice = readLine(), let mainPageOperationChoice = Int(mainPageOperationChoice) else {
                displayImproperInputStatus()
                continue
            }
            
            return mainPageOperationChoice
        }
    }
}
