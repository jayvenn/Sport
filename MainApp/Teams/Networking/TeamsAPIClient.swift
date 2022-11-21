//
//  TeamsAPIClient.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine
import Football
import SportAPI

final class TeamsAPIClient: TeamsFetchable {
    func getTeams() -> AnyPublisher<[Team], Error> {
        SportAPI.shared.makeUnauthenticatedPublisher(path: .teams)
    }
}
