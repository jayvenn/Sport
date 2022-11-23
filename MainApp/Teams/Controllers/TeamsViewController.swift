//
//  TeamsViewController.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import UIKit
import Combine
import FootballUI

final class TeamsViewController: UICollectionViewController {
    // MARK: - Properties
    private let viewModel: TeamsViewModel
    private lazy var teamsUIHandler = TeamsUIHandler(collectionView: collectionView)
    private var anyCancellables = Set<AnyCancellable>()
    // MARK: - Init
    init(viewModel: TeamsViewModel = TeamsViewModel()) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: ListCollectionLayout.make(.plain))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sinkTeamsSubject()
        viewModel.fetchTeams()
    }
    // MARK: - Overheads
    private func sinkTeamsSubject() {
        viewModel.teamsSubject.sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.presentErrorAlertController(
                    message: error.localizedDescription
                )
            }
        } receiveValue: { [weak self] teams in
            self?.teamsUIHandler.applyDataSourceSnapshot(
                hashableObjects: teams
            )
        }
        .store(in: &anyCancellables)
    }
}
// MARK: - UICollectionViewDelegate
extension TeamsViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        teamsUIHandler.selectItemAtIndexPath(indexPath, viewController: self, hashableObjects: viewModel.teamsSubject.value)
    }
}
