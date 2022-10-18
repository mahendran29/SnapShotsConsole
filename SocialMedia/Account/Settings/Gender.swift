//
//  Gender.swift
//  SocialMedia
//
//  Created by mahendra-pt5402 on 11/08/22.
//

import Foundation

enum Gender: Int,CustomStringConvertible {
    case male = 1
    case female
    
    var description: String {
        switch self {
        case .male: return "MALE 🤴🏻"
        case .female: return "FEMALE 👸"
        }
    }
}
