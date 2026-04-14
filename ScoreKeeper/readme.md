## [Data Modeling] 1-1. Custom types and Swift Testing : Model data with custom types

<https://developer.apple.com/tutorials/develop-in-swift/model-data-with-custom-types>

- Struct & Identifiable

  - 각 배열을 따로 관리하는 것보다 관련된 데이터(이름, 점수)를 하나의 구조체(Player)로 묶는 것이 안전하다
  - 구조체 안에 있는 데이터(이름, 점수)에 고유 ID를 부여하면 SwiftUI가 리스트를 정확하게 식별할 수 있다

''' struct Player: Identifiable {
    //이 데이터들은 각자 고유의 ID를 가지고 있음을 알려주기 위해 Identifiable을 사용
    
    let id = UUID()
    
    var name : String
    var score : Int
    //string과 int를 따로 관리하며, 두가지의 개수가 맞지 않으면 앱이 터질 수 있음
}
    
- Binding($)

  - 사용자의 입력과 실제 데이터를 실시간으로 연결해주는 문법
  - 변수 앞에 $를 붙여서 사용하기도 함
  
''' ForEach($players) { $player in
                    GridRow{
                        TextField("Name", text: $player.name)
                        Text("\(player.score)")
                        Stepper("\(player.score)", value: $player.score)
                            .labelsHidden()
                    }
                    //player 앞에 붙은 $는 사용자의 키보드와 player 배열을 실시간으로 이어줌

- Grid&GridRow

  - 화면을 행과 열로 나누어 요소를 정렬하는 방식
  - 단순히 쌓기만 하는 HStack, VStack과 달리 여러 줄에 걸쳐있는 요소들의 세로 줄 위치를 한줄로 맞출 수 있다
  
'''GridRow{
                    Text("Player")
                        .gridColumnAlignment(.leading)
                        //이 열에 있는 모든 요소들을 왼쪽으로 정렬한다
                    Text("Score")
                }

- Stepper & labelsHidden

  - Stepper는 사용자가 값을 1씩 올리거나 내릴 수 있게 하는 수치 조절기
  - labelshidden은 기본으로 Stepper가 가지고 있는 레이블(숫자)영역을 안보이게 하는 명령어
  
'''GridRow{
                        TextField("Name", text: $player.name)
                        Text("\(player.score)")
                        Stepper("\(player.score)", value: $player.score)
                            .labelsHidden()
                    }
                    //스텝퍼는 옆에 숫자를 두는게 기본, Score를 따로 만들었기 때문에 숨기기
                    //gridrow를 사용해 플레이어와 점수를 한줄로 정렬

## [Data Modeling] 1-2. Custom types and Swift Testing : Add functionality with Swift Testing

<https://developer.apple.com/tutorials/develop-in-swift/add-functionality-with-swift-testing>

- Enum & Case

  - 상태가 명확하게 나뉘는 상황(준비, 진행, 종료)에서 사용한다
  - 정해진 선택지(case) 안에서만 움직이도록 해 실수를 막아준다
  
  '''enum GameState {
    //enum은 상태가 명확하게 나뉘는 상황에서 사용됨, case와 함께 사용
    case setup
    case playing
    case gameOver
    
}

- Switch & Case

  - 현재 상태에 따라 화면에 보이는 버튼이나 기능을 바꿔서 보여줄 때 사용한다
  - 보여줄 버튼이나 기능이 없을 때는 EmptyView()를 사용할 수 있다
  
  '''switch scoreboard.state {
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
                
- Mutating & For in

  - 구조체(struct) 내부의 값을 직접 변경(리셋)하고 싶을 때 mutating을 사용한다
  - 반복문(for-in)을 사용하면 플레이어가 몇 명이든 한꺼번에 점수를 초기화할 수 있다
  
  '''mutating func resetScores(to newValue: Int) {
        //struct 내부의 값을 직접 변경(리셋)하고 싶을 때 mutating을 사용
        //to 뒤에 오는 수가 외부에 적용됨, newValue라는 변수를 사용해 점수를 유연하게 초기화 할 수 있게
        
        for index in 0..<players.count {
            players[index].score = newValue
        }
        //0번부터 players 숫자까지 세면서 괄호 안에 있는 행동을 반복
        //지목된 플레이어의 점수를 0으로 바꿔라
        
- Testing & #expect

  - 프로토타입을 다 만들고 기능이 의도대로 잘 작동하는지 미리 테스트 할 때 사용한다
  - #expect를 통해 내가 기대하는 값과 실제 값이 맞는지 확인한다
  
  '''@Test("Reset player scores", arguments: [0, 10, 20])
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
    
- thinMaterial

  - .thinMaterial은 뒤에 배경이 비치는 색상 효과?
  
  '''VStack(alignment: .leading) {
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
