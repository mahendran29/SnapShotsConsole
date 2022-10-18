//
//  HomePageView.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 12/08/22.
//

import Foundation

class HomePageView: BaseView,HomePageViewProtocol {
    
    // HOME PAGE OF THE APP
    func displayHomePage(){
        print("\n---------- SNAPSHOTS ---------------\n")
        for tab in HomepageNavigation.allCases {
            print("\(tab.rawValue).\(tab.description)",terminator: " ")
        }
        print("\n\n------------------------------------\n")
    }
    
    func getHomePageTabChoice() -> String {
        while true {
            print("Enter your choice: ")
            guard let tabChoice = readLine() else {
                displayImproperInputStatus()
                continue
            }
            
            print("-------------------------------")
            return tabChoice
        }
    }
}
