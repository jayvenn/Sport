//
//  MatchesViewModel.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine
import FootballCore
import FootballAWS

final class MatchesViewModel {
    // MARK: - Properties
    private var anyCancellables = Set<AnyCancellable>()
    private let apiClient: MatchesFetchable
    let matchesSubject = PassthroughSubject<[Match], Error>()
    var isUpcoming = true
    // MARK: - Init
    init(apiClient: MatchesFetchable = MatchesAPIClient()) {
        self.apiClient = apiClient
    }
    // MARK: - Methods
    func fetchMatches() {
        apiClient.getMatches().sink { [weak self] status in
            switch status {
            case .finished:
                break
            case .failure(let error):
                self?.matchesSubject.send(completion: .failure(error))
            }
        } receiveValue: { [weak self] matchesAPIResponse in
            guard let self = self else { return }
            let matches = self.isUpcoming
            ? matchesAPIResponse.matches.upcoming
            : matchesAPIResponse.matches.previous
            self.matchesSubject.send(matches)
        }
        .store(in: &anyCancellables)
    }
}
