//
//  MatchesAPIClient.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine
import FootballCore

public final class MatchesAPIClient: MatchesFetchable {
    public init() {
    }
    public func getMatches() -> AnyPublisher<MatchesAPIResponse, Error> {
        FootballAWS.shared.makeUnauthenticatedPublisher(path: .matches)
    }
}
