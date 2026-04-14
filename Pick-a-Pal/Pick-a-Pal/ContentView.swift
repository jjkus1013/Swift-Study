//
//  ContentView.swift
//  Pick-a-Pal
//
//  Created by ONE on 3/30/26.
//

import SwiftUI

struct ContentView: View {
    @State private var names: [String] = []
    @State private var nameToAdd = ""
    @State private var pickedName = ""
    @State private var shouldRemovePickedName = false
    //리스트 삭제를 위한 토글, 기본적으로 꺼져있음
    
    var body: some View {
        VStack {
            
            VStack(spacing: 8) {
                Image(systemName: "person.3.sequence.fill")
                    .foregroundStyle(.tint)
                    .symbolRenderingMode(.hierarchical)
                //아이콘 투명도를 다르게 하는 효과?
                Text("Pick-a-Pal")
            }
            .font(.title)
            .bold()
            
            Text(pickedName.isEmpty ? " " : pickedName)
            //if else 축약형이라고 보면 됨
            //->var displayName: String{ if pickedName.isEmpty
            //return" "} else{ return pickedName}
            //Text(displayName)
                .font(.title2)
                .bold()
                .foregroundStyle(.tint)
            
            List {
                ForEach(names, id: \.description){
                    name in Text(name)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            TextField("Add Name", text: $nameToAdd)
                .autocorrectionDisabled()
                .onSubmit {
                    if !nameToAdd.isEmpty{
                        names .append(nameToAdd)
                        nameToAdd = ""
                    }
                }
            
            Divider()
            //텍스트 필드와 버튼을 구별
            
            Toggle("Remove when picked" , isOn: $shouldRemovePickedName)
            
            Button {
                if let randomName = names.randomElement() {
                    pickedName = randomName
                    
                    if shouldRemovePickedName {
                        names.removeAll {
                            name in return (name == randomName)
                        }
                    }
                    
                } else {
                    pickedName = ""
                }
            } label: {
                Text("Pick Random Name")
                //다양한 디자인 요소를 추가하기 위해 레이블사용
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            //버튼을 누르면 저장된 이름 중 하나를 랜덤으로 선택해 위에 띄워줌
            //선택할 이름이 없을 때는 아무것도 띄우지 않음
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
