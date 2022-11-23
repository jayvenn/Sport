//
//  MatchesViewController.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import UIKit
import Combine
import FootballUI
import FootballCore

final class MatchesViewController: UICollectionViewController {
    // MARK: - UI Properties
    private let segmentedControl = UISegmentedControl(items: ["Upcoming", "Previous"])
    // MARK: - Business Properties
    private let viewModel: MatchesViewModel
    private lazy var matchesUIHandler = MatchesUIHandler(collectionView: collectionView)
    private var anyCancellables = Set<AnyCancellable>()
    // MARK: - Init
    init(viewModel: MatchesViewModel = MatchesViewModel()) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: ListCollectionLayout.make(.insetGrouped))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        sinkMatchesSubject()
        viewModel.fetchMatches()
    }
    // MARK: - Overheads
    private func setupNavigationBar() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
        let segmentBarItem = UIBarButtonItem(customView: segmentedControl)
        navigationItem.leftBarButtonItem = segmentBarItem
    }
    private func sinkMatchesSubject() {
        viewModel.matchesSubject.sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.presentErrorAlertController(
                    message: error.localizedDescription
                )
            }
        } receiveValue: { [weak self] matches in
            self?.matchesUIHandler.applyDataSourceSnapshot(
                hashableObjects: matches
            )
        }
        .store(in: &anyCancellables)
    }
    // MARK: - Actions
    @objc func segmentedValueChanged(_ sender: UISegmentedControl) {
        viewModel.isUpcoming = sender.selectedSegmentIndex == 0
    }
}
// MARK: - UICollectionViewDelegate
extension MatchesViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        matchesUIHandler.selectItemAtIndexPath(indexPath, viewController: self, hashableObjects: viewModel.matchesSubject.value)
    }
}
