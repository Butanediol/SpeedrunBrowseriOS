//
//  RunView.swift
//  Speedrun Browser
//
//  Created by Butanediol on 4/3/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import Parma

struct RunView: View {
    
    @ObservedObject var viewModel: RunsResultViewModel
    
    @State private var showCategoryRule = false
    
    var body: some View {
        
        ScrollView {
            banner
                .padding(.vertical)
            detail
                .padding()
        }
        .toolbar() {
            shareButton
        }
        .onAppear() {
            viewModel.getRuns()
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var banner: some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { geometry in
                bannerImage
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
                    .clipped()
                    .offset(x: 0, y: self.getOffsetForHeaderImage(geometry))
                    .padding(.top)
            }
               .frame(height: 300)
        
            HStack(alignment: .lastTextBaseline) {
                Text(viewModel.game.names.international)
                    .bold()
                    .font(.largeTitle)
                Spacer()
                Text(viewModel.game.id)
                    .font(.system(size: 12, design: .monospaced))
            }
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5)
                .padding(.horizontal)
        }
    }
    
    var bannerImage: some View {
        ZStack(alignment: .bottomLeading) {
            if let background = viewModel.game.assets.background {
                WebImage(url: URL(string: background.uri)!)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
            } else {
                WebImage(url: URL(string: viewModel.game.assets.coverLarge.uri)!)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
            }
        }
    }
    
    var shareButton: some View {
        Button(action: actionSheet, label: {
            Image(systemName: "square.and.arrow.up")
        })
    }
    
    // MARK: - Detail
    var detail: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    Picker(viewModel.selectedCategory?.name ?? "Select a category", selection: $viewModel.selectedCategory) {
                        ForEach(viewModel.gameCategories!.data) {
                            Text($0.name).tag(Optional($0))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .animation(.easeOut)
                }
                
                Spacer()
                
                Button("View rules") {
                    self.showCategoryRule = true
                }.sheet(isPresented: $showCategoryRule) {
                    NavigationView {
                        ScrollView {
                            Parma(viewModel.selectedCategory?.name == nil ? "Please select a category first." : viewModel.selectedCategory?.rules ?? "No rules given.")
                                .padding()
                        }
                        .navigationTitle("Rules - \(viewModel.selectedCategory?.name ?? viewModel.game.names.international)")
                    }
                }
            }
        }
    }
    
}

extension RunView {
    private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        
        // Image was pulled down
        if offset > 0 {
            return -offset
        }
        
        return 0
    }
    
    private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height

        if offset > 0 {
            return imageHeight + offset
        }

        return imageHeight
    }
    
    private func actionSheet() {
        guard let data = URL(string: viewModel.game.weblink) else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}
