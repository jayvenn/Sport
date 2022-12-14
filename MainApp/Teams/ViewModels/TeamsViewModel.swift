//
//  TeamsViewModel.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import Combine
import FootballCore
import FootballAWS

final class TeamsViewModel {
    // MARK: - Properties
    private var anyCancellables = Set<AnyCancellable>()
    private let apiClient: TeamsFetchable
    let teamsSubject = CurrentValueSubject<[Team], Error>([])
    // MARK: - Init
    init(apiClient: TeamsFetchable = TeamsAPIClient()) {
        self.apiClient = apiClient
    }
    // MARK: - Methods
    func fetchTeams() {
        apiClient.getTeams().sink { [weak self] status in
            switch status {
            case .finished:
                break
            case .failure(let error):
                self?.teamsSubject.send(completion: .failure(error))
            }
        } receiveValue: { [weak self] teamsAPIResponse in
            self?.teamsSubject.send(teamsAPIResponse.teams)
        }
        .store(in: &anyCancellables)
    }
}
