//
//  File.swift
//  Birthdays
//
//  Created by ONE on 4/19/26.
//


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