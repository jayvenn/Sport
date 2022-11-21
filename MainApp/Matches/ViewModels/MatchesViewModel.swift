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
    let matchesSubject = PassthroughSubject<MatchesAPIResponse, Error>()
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
        } receiveValue: { [weak self] response in
            self?.matchesSubject.send(response)
        }
        .store(in: &anyCancellables)
    }
}
