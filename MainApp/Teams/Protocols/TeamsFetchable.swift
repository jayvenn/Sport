//
//  TeamsFetchable.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine

protocol TeamsFetchable {
    func getTeams() -> AnyPublisher<[Team], Error>
}
