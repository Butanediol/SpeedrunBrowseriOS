//
//  GameCellView.swift
//  Speedrun Browser
//
//  Created by Butanediol on 2/3/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameCellView: View {
    
    let game: Game
    
    var body: some View {
        HStack(alignment: .top) {
            WebImage(url: URL(string: game.assets.coverMedium.uri))
                .placeholder(Image(systemName: "photo"))
                .resizable()
                .scaledToFill()
                .background(Color(.systemGray6))
                .frame(width: 60, height: 60)
                .cornerRadius(5)
                .shadow(radius: 5)
            VStack(alignment: .leading) {
                Text(game.names.international)
                    .bold()
                    .lineLimit(1)
                    .font(.headline)
                Text((game.names.japanese != nil) ? game.names.japanese! : game.names.twitch)
                    .lineLimit(1)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                IdBadge
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var IdBadge: some View {
        ZStack {
            Text(game.id)
                .font(.system(size: 12, design: .monospaced))
                .padding(3)
                .foregroundColor(.white)
                .background(Color.secondary)
                .clipShape(Capsule())
        }
    }
}
