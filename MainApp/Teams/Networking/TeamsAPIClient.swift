//
//  TeamsAPIClient.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine
import FootballCore
import SportAPI

final class TeamsAPIClient: TeamsFetchable {
    func getTeams() -> AnyPublisher<TeamsAPIResponse, Error> {
        SportAPI.shared.makeUnauthenticatedPublisher(path: .teams)
    }
}
