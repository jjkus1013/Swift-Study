//
//  ContentView.swift
//  OnboradingFlow
//
//  Created by ONE on 3/29/26.
//

import SwiftUI

let gradientColors: [Color] = [
    .gradientTop,
    .gradientBottom
]

struct ContentView: View {
    var body: some View {
        TabView {
            WelcomePage()
            FeaturesPage()
        }
        .background(Gradient(colors: gradientColors))
        .tabViewStyle(.page) //스와이프해서 볼 수 있음
        .foregroundStyle(.white)//텍스트 흰색으로
    }
}

#Preview {
    ContentView()
}
