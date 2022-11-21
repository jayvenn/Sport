//
//  MatchesAPIResponse.swift
//  SportData
//
//  Created by MyMac on 2022-11-21.
//

import Foundation

public struct MatchesAPIResponse {
    public struct MatchGroup {
        public let matches: [Match]
    }
    public let previous: MatchGroup
    public let upcoming: MatchGroup
}
