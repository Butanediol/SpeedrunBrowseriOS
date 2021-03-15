//
//  LeaderboardViewModel.swift
//  Speedrun Browser
//
//  Created by Butanediol on 15/3/2021.
//

import Foundation

class LeaderboardViewModel: ObservableObject {
    
    @Published var isLoading = true
    
    @Published var leaderboard: Leaderboard? = nil
    
    func getLeaderBoard(from urlString: String) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let newLeaderboard = try? decoder.decode(Leaderboard.self, from: data) {
                    DispatchQueue.main.async {
                        self.leaderboard = newLeaderboard
                        self.isLoading = false
                    }
                }
            }
        }
        task.resume()
    }
    
}
