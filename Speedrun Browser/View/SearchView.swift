//
//  SearchView.swift
//  Speedrun Browser
//
//  Created by Butanediol on 23/2/2021.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel = GameSearchViewModel()
    
//    init() {
//        // translucent navigation bar
//
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().tintColor = .clear
//        UINavigationBar.appearance().backgroundColor = .clear
//    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(searchText: $viewModel.searchText, action: {
                    viewModel.search()
                })
                    .padding([.horizontal, .bottom])
                VStack(alignment: .leading, spacing: 10) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if viewModel.gameResult == nil {
                        Text("Haven't requested or an error occurred.")
                            .foregroundColor(.secondary)
                    } else if viewModel.gameResult!.data.count != 0{
                        ForEach(viewModel.gameResult!.data) { game in
                            NavigationLink(destination:
                                RunView(viewModel: RunsResultViewModel(with: game))
                                            .edgesIgnoringSafeArea(.top)
                                            .navigationBarTitle("")
//                                WebView(url: URL(string: game.weblink)!)
//                                            .navigationTitle("\(game.names.international)")
                                            .navigationBarTitleDisplayMode(.inline)
//                                            .edgesIgnoringSafeArea(.bottom)
                            ) {
                                GameCellView(game: game)
                            }
                        }
                    } else {
                        VStack(spacing: 50) {
                            Text("No result.")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
//        .resignKeyboardOnDragGesture()
    }
}
