//
//  Leaderboard.swift
//  Speedrun Browser
//
//  Created by Butanediol on 15/3/2021.
//

import Foundation

struct Leaderboard: Codable {
    var data: LeaderboardData
}

struct LeaderboardData: Codable {
    var weblink: String
    var game: String
    var runs: [RankedRun]
}

struct RankedRun: Codable, Identifiable {
    var place: Int
    var id: Int {
        self.place
    }
    var run: Run
}
