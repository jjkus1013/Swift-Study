//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by ONE on 4/13/26.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreboard = ScoreBoard()
    @State private var startingPoints = 0
    //게임 시작 시 점수 0으로 초기화
    
    //문자열 배열 players 선언
    //정수형 배열 scores 선언, 요소가 비어있으면 충돌해 에러가 남
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score Keeper")
                .font(.title)
                .bold()
                .padding(.bottom)
            
            SettingsView(doesHighestScoreWin: $scoreboard.doesHighestScoreWin,
                         startingPoints: $startingPoints)
            .disabled(scoreboard.state != .setup)
            
            Grid {
                GridRow{
                    Text("Player")
                        .gridColumnAlignment(.leading)
                    Text("Score")
                }
                .font(.headline)
                
                ForEach($scoreboard.players) { $player in
                    GridRow{
                        HStack{
                            if scoreboard.winners.contains(player) {
                                Image(systemName: "crown.fill")
                                    .foregroundStyle(Color.yellow)
                            }
                            TextField("Name", text: $player.name)
                                .disabled(scoreboard.state != .setup)
                        }
                        Text("\(player.score)")
                            .opacity(scoreboard.state == .setup ? 0 : 1.0)
                        Stepper("\(player.score)", value: $player.score)
                            .labelsHidden()
                            .opacity(scoreboard.state == .setup ? 0 : 1.0)
                    }
                    //gridrow를 사용해 플레이어와 점수를 한줄로 정렬
                    //스텝퍼는 옆에 숫자를 두는게 기본, Score를 따로 만들었기 때문에 숨기기
                }
                //현재 player가 몇명인지 세어서 그만큼 텍스트필드를 세로로 그려줌
                //player 앞에 붙은 $는 사용자의 키보드와 player 배열을 실시간으로 이어줌
            }
            .padding(.vertical)
            
            Button("Add Player", systemImage: "plus") {
                scoreboard.players.append(Player(name: "", score: 0))
            }
            .opacity(scoreboard.state == .setup ? 1.0 : 0)
            //Add Player버튼을 누르면 빈 입력창이 하나 더 생김
            Spacer()
            
            HStack {
                Spacer()
                switch scoreboard.state {
                case .setup:
                    Button("Start Game", systemImage: "play.fill") {
                        scoreboard.state = .playing
                        scoreboard.resetScores(to: startingPoints)
                        //resetScore로 startingPoints를 외부에 보냄
                    }
                case .playing:
                    Button("End Game", systemImage: "stop.fill") {
                        scoreboard.state = .gameOver
                    }
                case .gameOver:
                    Button("Reset Game", systemImage: "arrow.counterclockswise") {
                        scoreboard.state = .setup
                        
                    }
                    //scoreboard가 어떤 상태인가에 따라 다른 버튼을 화면에 띄움
                    //setup 준비중 playing 게임진행중 gameover 게임끝
                    //버튼을 아예 숨기고 싶을때 EmptyView()를 사용할 수 있음
                }
                Spacer()
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
