//
//  GameResult.swift
//  Speedrun Browser
//
//  Created by Butanediol on 2021/2/27.
//

import Foundation

// MARK: - GameResult
struct GameResult: Codable {
    let pagination: Pagination
    let data: [Game]
}

// MARK: - Game
struct Game: Codable, Identifiable {
    let weblink: String
    let abbreviation: String
    let names: Names
    let id: String
    let assets: Assets
//    let assets: [String: Asset?]
}

// MARK: - Assets
struct Assets: Codable {
    let logo: Asset
    let coverTiny: Asset
    let coverSmall: Asset
    let coverMedium: Asset
    let coverLarge: Asset
    let icon: Asset
    let trophy1st: Asset
    let trophy2nd: Asset
    let trophy3rd: Asset
    let background, foreground, trophy4th: Asset?
//    let trophy3rd: Asset
    
    enum CodingKeys: String, CodingKey {
        case logo = "logo"
        case coverTiny = "cover-tiny"
        case coverSmall = "cover-small"
        case coverMedium = "cover-medium"
        case coverLarge = "cover-large"
        case icon
        case trophy1st = "trophy-1st"
        case trophy2nd = "trophy-2nd"
        case trophy3rd = "trophy-3rd"
        case trophy4th = "trophy-4th"
        case background
        case foreground
    }
}

struct Asset: Codable {
    let width: Int
    let height: Int
    let uri: String
}

// MARK: - Names
struct Names: Codable {
    let twitch: String
    let international: String
    let japanese: String?
}

// MARK: - Pagination
struct Pagination: Codable {
    let max: Int
    var links : [Link]
    let offset, size: Int
}

struct Link: Codable, Hashable {
    let rel, uri: String
}
