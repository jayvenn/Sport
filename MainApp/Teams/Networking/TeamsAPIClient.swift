//
//  TeamsAPIClient.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine
import FootballCore
import FootballAWS

final class TeamsAPIClient: TeamsFetchable {
    func getTeams() -> AnyPublisher<TeamsAPIResponse, Error> {
        FootballAWS.shared.makeUnauthenticatedPublisher(path: .teams)
    }
}
