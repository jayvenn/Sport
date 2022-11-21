//
//  Match.swift
//  SportMatches
//
//  Created by MyMac on 2022-11-21.
//

import Foundation

struct Match: Decodable {
    let date: Date
    let description: String
    let home: String
    let away: String
    let winner: String
    let highlights: URL
}
