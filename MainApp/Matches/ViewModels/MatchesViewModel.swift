//
//  MatchesViewModel.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine
import SportAPI

final class MatchesViewModel {
    // MARK: - Properties
    private var anyCancellables = Set<AnyCancellable>()
    private let apiClient: MatchesFetchable
    let matchesSubject = PassthroughSubject<[Match], Error>()
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
        } receiveValue: { [weak self] matches in
            self?.matchesSubject.send(matches)
        }
        .store(in: &anyCancellables)
    }
}
