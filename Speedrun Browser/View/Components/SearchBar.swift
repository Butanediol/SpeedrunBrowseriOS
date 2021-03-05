//
//  SearchBar.swift
//  Speedrun Browser
//
//  Created by Butanediol on 4/3/2021.
//

import SwiftUI

struct SearchBar: View {
    
    let placeholder = "Search..."
    
    @Binding var searchText: String
    
    let action: () -> ()
    
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            
            ZStack {
                TextField(placeholder, text: $searchText, onCommit: {
                    action()
                    endEdit()
                })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    overlay
                )
                .animation(.spring())
                .onTapGesture {
                    self.isEditing = true
                }
                
            }
            
            if isEditing {
                Button("Search") {
                    action()
                    endEdit()
                }
                .opacity(isEditing ? 1 : 0)
                .animation(.easeInOut)
            }
        }
    }
    
    var overlay: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)
     
            if isEditing {
                Button(action: {
                    self.searchText = ""
                    endEdit()
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
            }
        }
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func endEdit() {
        dismissKeyboard()
        self.isEditing = false
    }
}
