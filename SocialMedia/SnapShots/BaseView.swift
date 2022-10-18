//
//  BaseView.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 19/09/22.
//

import Foundation

class BaseView {
    
    func displayImproperInputStatus() {
        displayInformationToUser(details: "⚠️ GIVE PROPER INPUT!")
    }
    
    func displayInformationToUser(details: String) {
        print("\n")
        for _ in 1...details.count {
            print("-",terminator: "")
        }
        print("\n\(details)")
        for _ in 1...details.count {
            print("-",terminator: "")
        }
        print("\n")
    }
}
