//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-22.
//

import UIKit
import FootballCore
import SDWebImage

public final class TeamCollectionViewCell: UICollectionViewListCell {
    // MARK: - Properties
    private func defaultListContentConfiguration() -> UIListContentConfiguration { .cell() }
    private lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private var customViewConstraints: (
        profileImageTop: NSLayoutConstraint,
        profileImageBottom: NSLayoutConstraint
    )?
    private var team: Team?
    func configureCell(
        _ newTeam: Team
    ) {
        guard team != newTeam else { return }
        team = newTeam
        setNeedsUpdateConfiguration()
    }
    public override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.team = team
        return state
    }
    // MARK: - Layouts
    private func setupViewsIfNeeded() {
        guard customViewConstraints == nil else { return }
        profileImageView.contentMode = .scaleAspectFit
        contentView.addSubview(listContentView)
        contentView.addSubview(profileImageView)
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byCharWrapping
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        listContentView.translatesAutoresizingMaskIntoConstraints = false
        let customViewConstraints = (
            profileImageView.heightAnchor.constraint(equalToConstant: 36),
            profileImageView.widthAnchor.constraint(equalToConstant: 36)
        )
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: listContentView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            customViewConstraints.0,
            customViewConstraints.1,
            listContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            listContentView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 0),
            listContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        self.customViewConstraints = customViewConstraints
    }
    // MARK: - Cell Configurations
    public override func updateConfiguration(using state: UICellConfigurationState) {
        guard let team = state.team else { return }
        setupViewsIfNeeded()
        var content = defaultListContentConfiguration()
            .updated(for: state)
        content.imageProperties.preferredSymbolConfiguration =
            .init(font: content.textProperties.font, scale: .large)
        content.axesPreservingSuperviewLayoutMargins = []
        let valueConfiguration = UIListContentConfiguration.valueCell().updated(for: state)
        profileImageView.sd_setImage(with: team.logo)
        profileImageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(
            font: valueConfiguration.secondaryTextProperties.font,
            scale: .small
        )
        content.text = state.team?.name ?? ""
        listContentView.configuration = content
    }
}
private extension UIConfigurationStateCustomKey {
    static let team = UIConfigurationStateCustomKey(
        "com.jayvenn.TeamCollectionViewCell.team"
    )
}
private extension UICellConfigurationState {
    var team: Team? {
        get { return self[.team] as? Team }
        set { self[.team] = newValue }
    }
}
