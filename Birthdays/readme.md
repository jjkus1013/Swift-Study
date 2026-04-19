## [Data Modeling] Models and persistence : Save data

<https://developer.apple.com/tutorials/develop-in-swift/save-data>

-@Model(SwiftData)

  -데이터를 저장하기 위한 모델 설정
  -클래스 위에 붙여야 context.insert로 데이터 저장이 가능함
  
  ```
  @Model
class Friend {
    var name: String
    var birthday: Date
    
    init(name: String, birthday: Date) {
        self.name = name
        self.birthday = birthday
    }
    
    var isBirthdayToday: Bool {
        Calendar.current.isDateInToday(birthday)
    }
}
  ```
  
-@Query

  -저장된 데이터를 자동으로 불러와 리스트에 출력함
  -데이터 변경 시 UI가 실시간으로 갱신됨
  
```
    @Query(sort: \Friend.birthday) private var friends: [Friend]
```

-@Environment

  -앱의 데이터 저장소(modelContext)에 접근하기 위해 사용
  -데이터를 추가하거나 삭제하는 등 제어 기능을 제공
  
```
    @Environment(\.modelContext) private var context
```
  
-safeAreaInset

  -리스트 하단에 입력 폼을 고정함
  -리스트와 UI 영역을 분리해서 스크롤해도 입력 폼은 아래에 고정됨
  
```
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
```


  
