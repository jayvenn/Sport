//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-21.
//

import Foundation

public struct MatchesAPIResponse: Decodable {
    struct Matches: Decodable {
        public let previous: [Match]
        public let upcoming: [Match]
    }
    public struct MatchGroup: Decodable {
        public let matches: [Match]
    }
    let matches: Matches
}
