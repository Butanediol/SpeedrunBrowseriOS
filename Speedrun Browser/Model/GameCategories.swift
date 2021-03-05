//
//  GameCategories.swift
//  Speedrun Browser
//
//  Created by Butanediol on 5/3/2021.
//


import Foundation

// MARK: - GameCategories
struct GameCategories: Codable {
    let data: [GameCategory]
    var categoryNames: Array<String> {
        data.map{ category in
            category.name
        }
    }
}

// MARK: - Datum
struct GameCategory: Codable, Identifiable, Hashable {
    static func == (lhs: GameCategory, rhs: GameCategory) -> Bool {
        if lhs.name == rhs.name &&
            lhs.rules == rhs.rules {
            return true
        } else {
            return false
        }
    }
    
    let name: String
    let rules: String?
    let players: Players
    let links: [Link]
    let type: DatumType
    let id: String
    let weblink: String
    let miscellaneous: Bool
}

let emptyGameCategory = GameCategory(name: "", rules: nil, players: Players(value: 1, type: ""), links: [], type: .perGame, id: "", weblink: "", miscellaneous: false)
//enum Rel: String, Codable {
//    case game = "game"
//    case leaderboard = "leaderboard"
//    case records = "records"
//    case relSelf = "self"
//    case runs = "runs"
//    case variables = "variables"
//}

// MARK: - Players
struct Players: Codable, Hashable {
    let value: Int
    let type: String
}

//enum PlayersType: String, Codable {
//    case exactly = "exactly"
//}

enum DatumType: String, Codable {
    case perGame = "per-game"
    case perLevel = "per-level"
}
