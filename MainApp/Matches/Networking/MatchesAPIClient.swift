//
//  MatchesAPIClient.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine
import SportAPI
import Football

final class MatchesAPIClient: MatchesFetchable {
    func getMatches() -> AnyPublisher<MatchesAPIResponse, Error> {
        SportAPI.shared.makeUnauthenticatedPublisher(path: .matches)
    }
}
