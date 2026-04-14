//
//  FeaturesPage.swift
//  OnboradingFlow
//
//  Created by ONE on 3/29/26.
//

import SwiftUI

struct FeaturesPage: View {
    var body: some View {
        VStack(spacing: 30) {
            //텍스트/카드/카드 사이 간격 줌
            Text("Features")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom)
                .padding(.top, 100)
            
            FeatureCard(
                iconName: "person.2.crop.square.stack.fill",
                description: "A multiline description about a feature paired with the image on the left."
            )
            
            FeatureCard(
                iconName: "quote.bubble.fill",
                description: "Short summary"
            )
            Spacer() //아래에 공간 채워 위쪽으로 정렬
        }
        .padding()
    }
}

#Preview {
    FeaturesPage()
        .frame(maxHeight: .infinity)//화면 가득 채우기
        .background(Gradient(colors: gradientColors))
    //이 페이지에 없기 때문에 임시로 불러?옴
        .foregroundStyle(.white)
}
