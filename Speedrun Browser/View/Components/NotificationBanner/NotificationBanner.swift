//
//  NotificationBanner.swift
//  Speedrun Browser
//
//  Created by Butanediol on 8/3/2021.
//

import SwiftUI

struct NotificationBanner: ViewModifier {
    
    var data: BannerData
    
    @Binding var show: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(data.title)
                                .bold()
                            Text(data.detail)
                                .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                        }
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .padding(12)
                    .background(data.type.tintColor)
                    .cornerRadius(8)
                    Spacer()
                }
                .padding()
                .animation(.easeInOut)
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }
                }.onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            self.show = false
                        }
                    }
                })
            }
        }
    }
}

struct BannerData {
    var title: String
    var detail: String
    var type: BannerType
}

enum BannerType {
    case Info, Warning, Success, Error
    
    var tintColor: Color {
        switch self {
        case .Info:
            return Color(red: 67/255, green: 154/255, blue: 215/255)
        case .Success:
            return Color.green
        case .Warning:
            return Color.yellow
        case .Error:
            return Color.red
        }
    }
}

extension View {
    func banner(data: BannerData, show: Binding<Bool>) -> some View {
        self.modifier(NotificationBanner(data: data, show: show))
    }
}
