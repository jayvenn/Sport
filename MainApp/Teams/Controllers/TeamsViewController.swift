//
//  TeamsViewController.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import UIKit
import Combine
import FootballUI

final class TeamsViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: TeamsViewModel
    private lazy var teamsUIHandler = TeamsUIHandler(collectionView: collectionView)
    private var anyCancellables = Set<AnyCancellable>()
    // MARK: - Init
    init(viewModel: TeamsViewModel = TeamsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMatches()
    }
}
