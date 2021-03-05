//
//  GameSearchViewModel.swift
//  Speedrun Browser
//
//  Created by Butanediol on 2/3/2021.
//

import Foundation
import UIKit

let sampleData = NSDataAsset(name: "GameResultSample")!.data
let sampleGameResult = try! JSONDecoder().decode(GameResult.self, from: sampleData)

class GameSearchViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var gameResult: GameResult? = nil
    
    func search() {
        
        self.isLoading = true

        var urlComponent = URLComponents(string: "https://www.speedrun.com/api/v1/games")!
        urlComponent.queryItems = []
        urlComponent.queryItems?.append(URLQueryItem(name: "name", value: self.searchText))
        
        let task = URLSession.shared.dataTask(with: urlComponent.url!) { data, resposne, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.gameResult = try? JSONDecoder().decode(GameResult.self, from: data)
                    self.isLoading = false
                }
            }
        }
        
        task.resume()
    }
}
