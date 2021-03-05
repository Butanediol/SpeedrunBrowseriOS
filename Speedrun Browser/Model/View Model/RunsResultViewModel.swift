//
//  RunsResultViewModel.swift
//  Speedrun Browser
//
//  Created by Butanediol on 4/3/2021.
//

import Foundation
import UIKit

class RunsResultViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var runsResult: RunsResult? = nil
    @Published var gameCategories: GameCategories? = nil
    @Published var selectedCategory: GameCategory?
    
    var game: Game
    
    init(with game: Game) {
        self.isLoading = true
        self.game = game
    }
    
    func getRuns() {
        
        var urlComponent = URLComponents(string: "https://www.speedrun.com/api/v1/runs")!
        urlComponent.queryItems = []
        urlComponent.queryItems?.append(URLQueryItem(name: "game", value: self.game.id))
        
        let task = URLSession.shared.dataTask(with: urlComponent.url!) { data, response, error in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let newRun = try decoder.decode(RunsResult.self, from: data)
//                    print(newRun)
                } catch {
                    print(error)
                    
                    let clipboard = UIPasteboard.general
                    clipboard.string = String(data: data, encoding: .utf8)
                }
//                if newRun != nil {
//                    DispatchQueue.main.async {
//                        self.runsResult = newRun!
//                    }
//                }
            }
        }
        
        task.resume()
        getCategories()
    }
    
    func getCategories() {
        let url = URL(string: "https://www.speedrun.com/api/v1/games/\(game.id)/categories")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let newGameCategories = try decoder.decode(GameCategories.self, from: data)
                    DispatchQueue.main.async {
                        self.gameCategories = newGameCategories
                        self.isLoading = false
                    }
                } catch {
                    print(error)
                }
            }

        }
        task.resume()
    }
    
}
