//
//  MatchesFetchable.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine
import FootballCore

protocol MatchesFetchable {
    func getMatches() -> AnyPublisher<MatchesAPIResponse, Error>
}
