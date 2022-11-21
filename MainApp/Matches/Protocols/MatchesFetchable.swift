//
//  MatchesFetchable.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine

protocol MatchesFetchable {
    func getMatches() -> AnyPublisher<[Match], Error>
}
