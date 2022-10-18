//
//  PostsPage.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 19/08/22.
//

import Foundation

enum PostPage: Int, CaseIterable, CustomStringConvertible {
    case newPost = 1
    case allPost

    var description: String {
        switch self {
        case .newPost: return "ADD NEW POST ➕"
        case .allPost: return "SHOW ALL POSTS 🙌"
        }
    }
}

enum PostOperation: Int, CaseIterable, CustomStringConvertible {
    case like = 1
    case allLikes
    case comment
    case editCaption
    case delete

    var description: String {
        switch self {
        case .like: return "LIKE 🆒"
        case .allLikes: return "ALL LIKES 👍"
        case .comment: return "COMMENT 🔠"
        case .editCaption: return "EDIT CAPTION 🔠"
        case .delete: return "DELETE 👎❌"
        }
    }
}

enum CommentOperation: Int, CaseIterable, CustomStringConvertible {
    case addComment = 1
    case viewComment

    var description: String {
        switch self {
        case .addComment: return "ADD COMMENT 🆒"
        case .viewComment: return "VIEW COMMENTS 👍"
        }
    }
}
