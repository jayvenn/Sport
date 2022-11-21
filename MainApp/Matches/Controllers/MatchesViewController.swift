//
//  MatchesViewController.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import UIKit
import Combine

final class MatchesViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: MatchesViewModel
    private var anyCancellables = Set<AnyCancellable>()
    // MARK: - Init
    init(viewModel: MatchesViewModel = MatchesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sinkMatchesSubject()
        viewModel.fetchMatches()
    }
    // MARK: - Overheads
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
        } receiveValue: { matches in
            print("Matches:")
            print(matches)
            // Load data
        }
        .store(in: &anyCancellables)
    }
}
