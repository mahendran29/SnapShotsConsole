//
//  HomePageController.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 19/09/22.
//

import Foundation

class HomePageController {
    
    private let homePageView: HomePageViewProtocol
    init(homePageView: HomePageViewProtocol) {
        self.homePageView = homePageView
    }
    
    func startHomePage(userID: Int) {
        while true {
            
            homePageView.displayHomePage()
            let homePageTabChoice = homePageView.getHomePageTabChoice()
            guard let homePageTabChoice = Int(homePageTabChoice),
                  let homePageTab = HomepageNavigation(rawValue: homePageTabChoice) else {
                homePageView.displayImproperInputStatus()
                continue
            }
            
            switch homePageTab {
                case HomepageNavigation.feeds:
                    AppNavigator.moveTo(destination: .feeds, args: ["user": userID])

                case HomepageNavigation.people:
                    AppNavigator.moveTo(destination: .people, args: ["user": userID])
                   
                case HomepageNavigation.profile:
                    AppNavigator.moveTo(destination: .profile, args: ["user": userID])
            }
        }
    }
}
