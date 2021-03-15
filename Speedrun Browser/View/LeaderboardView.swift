//
//  LeaderboardView.swift
//  Speedrun Browser
//
//  Created by Butanediol on 15/3/2021.
//

import SwiftUI

struct LeaderboardView: View {
    
    @ObservedObject var viewModel = LeaderboardViewModel()
    
    let urlString: String
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                if let runs = viewModel.leaderboard?.data.runs {
                    ForEach(runs) { rankedRun in
                        Text(String(rankedRun.id))
                    }
                }
            }
        }
        .onAppear() {
            viewModel.getLeaderBoard(from: self.urlString)
        }
    }
}
