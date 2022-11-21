//
//  MatchesAPIClient.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine
import FootballAWS
import FootballCore

final class MatchesAPIClient: MatchesFetchable {
    func getMatches() -> AnyPublisher<MatchesAPIResponse, Error> {
        FootballAWS.shared.makeUnauthenticatedPublisher(path: .matches)
    }
}
