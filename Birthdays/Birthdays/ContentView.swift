//
//  ContentView.swift
//  Birthdays
//
//  Created by ONE on 4/19/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Friend.birthday) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
//@State private var friends: [Friend] = [
//        Friend(name: "Elton Lin", birthday: .now),
//        Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0))
        //timeIntervalSince는 유닉스타임스탬프, 컴퓨터시간의 시작인 1970-01-01을 나타냄
        //날짜 데이터의 초기값이라고 보면 됨
//]
    
    @State private var newName = ""
    @State private var newDate = Date.now
    //newDate에 지금 이 순간의 시간을 저장해
    
    var body: some View {
        NavigationStack {
            List(friends) { friend in
                //fritends라는 배열을 화면에 뿌리고 그 안에 있는 요소는 friend라고 이름 지음
                HStack {
                    if friend.isBirthdayToday {
                        Image(systemName: "birthday.cake")
                    }
                    Text(friend.name)
                        .bold(friend.isBirthdayToday)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                    //가로로 배치, 친구 이름은 왼쪽, 중간 공백, 친구 생일은 오른쪽에
                }
            }
            .navigationTitle("Birthdays")
            //네비게이션 스택은 화면전환이 가능한 무언가를 만들고 싶을 때 사용
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                        .textFieldStyle(.roundedBorder)}
                    //새로운 리스트를 추가할 수 있는 컴포넌트?들
                    //날짜를 선택하는 데이트 픽커, 이름을 설정할 수 있는 텍스트 필드
                    //데이트 픽커로 1970년부터 현재까지의 날짜만 선택할 수 있음(미래X)
                    //displayedComponents: .date -> 날짜를 어떻게 보여줄 것인가(년/월/일)
                        Button("Save") {
                            let newFriend = Friend(name: newName, birthday: newDate)
                            context.insert(newFriend)
                            
                            newName = ""
                            newDate = .now
                            //let은 고정된 값을 넣은 상자를 만들때 사용
                            //newFriend는 name과 birthday 속성을 가지고 있음
                            //name은 기본값이 비어있고, birthday는 현재 시간임
                        }
                        
                    .bold()
                }
                .padding()
                .background(.bar) //해당 구간 뒤에만 하얗게 백그라운드가 깔림
            }
        }
    }
}

#Preview {
    ContentView()
    
        .modelContainer(for: Friend.self, inMemory: true)
}
