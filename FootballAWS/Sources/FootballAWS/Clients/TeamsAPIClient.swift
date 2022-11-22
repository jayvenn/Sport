//
//  TeamsAPIClient.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine
import FootballCore

public final class TeamsAPIClient: TeamsFetchable {
    public init() {
    }
    public func getTeams() -> AnyPublisher<TeamsAPIResponse, Error> {
        FootballAWS.shared.makeUnauthenticatedPublisher(path: .teams)
    }
}
