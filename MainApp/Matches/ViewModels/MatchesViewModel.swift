//
//  MatchesViewModel.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine

final class MatchesViewModel {
    // MARK: - Properties
    private var anyCancellables = Set<AnyCancellable>()
    private var matchesFetchable: MatchesFetchable
    // MARK: - Init
    init(matchesFetchable: MatchesFetchable) {
        self.matchesFetchable = matchesFetchable
    }
}
