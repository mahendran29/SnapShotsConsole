//
//  NavigationController.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 20/09/22.
//

import Foundation

class AppNavigator {
    
    enum Destination {
        case login
        case signUp
        case forgotPassword
        case feeds
        case people
        case settings
        case profileDetails
        case friends
        case post
        case homePage
        case mainPage
        case profile
    }
        
    static func moveTo(destination: Destination, args: [String: Any]? = nil) {
        
        switch destination {

        case .login: moveToLoginPage()
        case .signUp: moveToSignUpPage()
        case .forgotPassword: moveToForgotPassword()
        case .feeds: moveToFeedsTab(args: args)
        case .people: moveToPeopleTab(args: args)
        case .settings: moveToSettingsPage(args: args)
        case .profileDetails: moveToProfileDetails(args: args)
        case .friends: moveToFriends(args: args)
        case .post: moveToPost(args: args)
        case .homePage: moveToHomePage(args: args)
        case .mainPage: moveToMainPage()
        case .profile: moveToProfilePage(args: args)
        }
    }
    
    private static func moveToLoginPage() {
        LoginController(loginView: LoginView()).executeLoginProcess()
    }
    
    private static func moveToSignUpPage() {
        SignUpController(signUpView: SignUpView()).executeSignUpProcess()
    }
    
    private static func moveToForgotPassword() {
        ForgotPasswordController(forgotPasswordView: ForgotPasswordView()).executeForgotPasswordProcess()
    }
    
    private static func moveToFeedsTab(args: [String:Any]?) {
        guard let arguments = args,
              let userID = arguments["user"] as? Int else {
            fatalError("Must passs required arguments")
        }
        
        FeedsController(feedsView: FeedsView()).showFeedsTab(userID: userID)
    }
    
    private static func moveToPeopleTab(args: [String:Any]?) {
        guard let arguments = args,
              let userID = arguments["user"] as? Int else {
            fatalError("Must passs required arguments")
        }
        
        PeopleController(peopleView: PeopleView()).showPeopleTab(loggedUserID: userID)
    }
    
    private static func moveToSettingsPage(args: [String: Any]?) {
        guard let arguments = args,
              let userID = arguments["user"] as? Int else {
            fatalError("Must passs required arguments")
        }
        
        SettingsController(settingsView: SettingsView()).openSettings(userID: userID)
    }
    
    private static func moveToProfileDetails(args: [String: Any]?) {
        guard let arguments = args,
              let loggedUserID = arguments["user"] as? Int else {
            fatalError("Must passs required arguments")
        }
        
        ProfileDetailsController(profileDetailsView: ProfileDetailsView()).showProfileDetails(loggedUserID: loggedUserID)
    }
    
    private static func moveToFriends(args: [String: Any]?) {
        guard let arguments = args,
              let userID = arguments["user"] as? Int else {
            fatalError("Must passs required arguments")
        }
        
        FriendsController(friendsView: FriendsView()).showFriendsOperations(userID: userID)
    }
    
    private static func moveToPost(args: [String: Any]?) {
        guard let arguments = args,
              let userID = arguments["user"] as? Int else {
            fatalError("Must passs required arguments")
        }
        
        let visitingUserID = arguments["visitor"] as? Int
        let post = arguments["post"] as? Post
        
        let postController = PostController(postView: PostsView())

        if visitingUserID == nil {
            postController.getPostOperation(loggedUserID: userID)
        } else {
            postController.getAllPosts(loggedUserID: userID, visitingUserID: visitingUserID!,  currentPost: post)
        }
    }
    
    private static func moveToHomePage(args: [String: Any]?) {
        guard let arguments = args,
              let userID = arguments["user"] as? Int else {
            fatalError("Must passs required arguments")
        }
        
        HomePageController(homePageView: HomePageView()).startHomePage(userID: userID)
    }
    
    private static func moveToMainPage() {
        SnapShotsController(applicationView: SnapShotsView()).executeSnapShots()
    }
    
    private static func moveToProfilePage(args: [String: Any]?) {
        guard let arguments = args,
              let userID = arguments["user"] as? Int else {
            fatalError("Must passs required arguments")
        }
        ProfileController(profileView:ProfileView()).openProfileTab(userID: userID)
    }
}
