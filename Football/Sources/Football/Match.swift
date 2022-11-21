//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-21.
//

import Foundation

public struct Match: Decodable {
    public let date: Date
    public let description: String
    public let home: String
    public let away: String
    public let winner: String?
    public let highlights: URL?
}
