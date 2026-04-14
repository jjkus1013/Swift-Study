//
//  SettingsView.swift
//  ScoreKeeper
//
//  Created by ONE on 4/13/26.
//

import SwiftUI

struct SettingsView: View {
    @Binding var doesHighestScoreWin: Bool
    @Binding var startingPoints: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Game Rules")
                .font(.headline)
            Divider() //구분선
            Picker("Win condition", selection: $doesHighestScoreWin) {
                Text("Highest Score Wins")
                    .tag(true)
                Text("Lowest Score Wins")
                    .tag(false)
            }
            Picker("Starting points", selection: $startingPoints) {
                Text("0 starting points")
                    .tag (0)
                Text("10 starting points")
                    .tag (10)
                Text("20 starting points")
                    .tag (20)
                
            }
        }
        .padding()
        .background(.thinMaterial, in: .rect(cornerRadius: 10.0))
        //뒤에 배경이 비치는 은은한 회색, rect라고도 쓸 수 있음 !!
        
    }
}

#Preview {
    @Previewable @State var doesHighestScoreWin = true
    @Previewable @State var startingPoints = 10
    SettingsView(doesHighestScoreWin: $doesHighestScoreWin,
                 startingPoints: $startingPoints)
    //프리뷰를 처음 켰을 때 10점에서 시작하도록
}
