//
//  Player.swift
//  ScoreKeeper
//
//  Created by ONE on 4/13/26.
//

import Foundation

struct Player: Identifiable {
    //이 데이터들은 각자 고유의 ID를 가지고 있음을 알려주기 위해 Identifiable을 사용
    
    let id = UUID()
    
    var name : String
    var score : Int
    //string과 int를 따로 관리하며, 두가지의 개수가 맞지 않으면 앱이 터질 수 있음
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.name == rhs.name && lhs.score == rhs.score
        //lhs는 좌측, rhs는 우측
    }
}
