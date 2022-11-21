//
//  Team.swift
//  SportMatches
//
//  Created by MyMac on 2022-11-21.
//

import Foundation

struct Team: Decodable {
    let id: UUID
    let name: String
    let logo: URL
}
