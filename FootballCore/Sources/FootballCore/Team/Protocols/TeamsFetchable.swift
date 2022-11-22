//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-21.
//

import Combine

public protocol TeamsFetchable {
    func getTeams() -> AnyPublisher<TeamsAPIResponse, Error>
}
