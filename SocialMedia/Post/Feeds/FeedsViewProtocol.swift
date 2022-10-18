//
//  FeedsViewProtocol.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 23/08/22.
//

import Foundation

protocol FeedsViewProtocol: BaseProtocol {
    func displayAllPosts(entireFeed: [(userId: Int, userName: String, post: Post)])
    func isViewingParticularPost() -> Bool
    func getPostChoiceFromUser() -> Int
}
