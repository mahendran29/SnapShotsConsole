//
//  DatabaseProtocol.swift
//  SocialMedia
//
//  Created by mahendran-14703 on 06/10/22.
//

import Foundation

protocol DatabaseProtocol {
    func retrievingQuery(query: String) -> [Int: [String]]
    func booleanQuery(query: String) -> Bool
    func execute(query: String) -> Bool
}
