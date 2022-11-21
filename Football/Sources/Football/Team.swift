//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-21.
//

import Foundation

public struct Team: Decodable {
    public let id: UUID
    public let name: String
    public let logo: URL
}

