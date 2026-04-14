//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by ONE on 4/13/26.
//

import Testing
@testable import ScoreKeeper

//프로토타입을 다 만들고 목적지로 잘 가는지, 오류는 없는지 테스트하는 과정

struct ScoreKeeperTests {

    @Test("Reset player scores", arguments: [0, 10, 20])
    func resetScores(to newValue: Int) async throws {
        
        var scoreboard = ScoreBoard(players: [
            Player(name: "Elisha", score: 0),
            Player(name: "Andre", score: 5),
            //테스트 진행을 위해 안드레에게 5점을 준 상황
        ])
        scoreboard.resetScores(to: newValue)
        //아까 만든 resetScores 함수를 실행, 모두 0점으로
        
        for player in scoreboard.players {
            #expect(player.score == newValue)
            //#expect 내가 기대하는 점수와 실제 점수가 맞는지 기대하기
            //기대와 실제가 같으면 초록색 체크, 다르면 빨간색 엑스
        }
    }
    
    @Test("Highest score wins")
    func highestScoreWins() {
        let scoreboard = ScoreBoard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4),
            ],
            state: .gameOver,
            doesHighestScoreWin: true
        )
        let winners = scoreboard.winners
        #expect(winners == [Player(name: "Andre", score: 4)])
    }

    @Test("Lowest score wins")
    func lowestScoreWins() {
        let scoreboard = ScoreBoard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4)
            ],
            state: .gameOver,
            doesHighestScoreWin: true
        )
        let winners = scoreboard.winners
        #expect(winners == [Player(name: "Andre", score: 4)])
    }
}
