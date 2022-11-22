//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-21.
//

import Foundation

public struct Match: Hashable, Decodable {
    public let date: Date
    public let description: String
    public let home: String
    public let away: String
    public let winner: String?
    public let highlights: URL?
    public init(date: Date, description: String, home: String, away: String, winner: String?, highlights: URL?) {
        self.date = date
        self.description = description
        self.home = home
        self.away = away
        self.winner = winner
        self.highlights = highlights
    }
    public func hash(into hasher: inout Hasher) {
        [
            date.description,
            description,
            home,
            away,
            winner?.description ?? "",
            highlights?.description ?? ""
        ]
            .forEach { hasher.combine($0) }
    }
}
