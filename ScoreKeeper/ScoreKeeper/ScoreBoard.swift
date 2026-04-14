//
//  ScoreBoard.swift
//  ScoreKeeper
//
//  Created by ONE on 4/13/26.
//

import Foundation

struct ScoreBoard {
    var players : [Player] = [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 0),
        Player(name: "Jasmine", score: 0),
    ]
    
    var state = GameState.setup
    var doesHighestScoreWin = true
    
    var winners: [Player] {
        guard state == .gameOver else { return []}
        
        var winningScore = 0
        if doesHighestScoreWin {
            winningScore = Int.min
            for player in players {
                winningScore = max(player.score, winningScore)
            }
        } else {
            winningScore = Int.max
            for player in players {
                winningScore = min(player.score, winningScore)
            }
        }
        return players.filter { player in
            player.score == winningScore
        }
    }
    
    mutating func resetScores(to newValue: Int) {
        //struct 내부의 값을 직접 변경(리셋)하고 싶을 때 mutating을 사용
        //to 뒤에 오는 수가 외부에 적용됨, newValue라는 변수를 사용해 점수를 유연하게 초기화 할 수 있게
        
        for index in 0..<players.count {
            players[index].score = newValue
        }
        //0번부터 players 숫자까지 세면서 괄호 안에 있는 행동을 반복
        //지목된 플레이어의 점수를 0으로 바꿔라
    }
}
