import SwiftUI

struct ContentView: View {
    
    @State var isSparkled:Bool=false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red,.pink,.purple], startPoint: .top, endPoint: .bottom)
            // 텍스트를 넣어보세요.
            VStack{
                Text("고양이가 나타났다 !")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .shadow(radius: 3)
                
                Image("cat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .scaleEffect(isSparkled ? 1.0: 2.0)
                    .opacity(isSparkled ? 1.0: 0.7)
                    .animation(.easeInOut(duration:0.1).repeatCount(5),
                               value: isSparkled)
                
                Button{
                    isSparkled.toggle()
                }label: {
                    Text("건드리기")
                        .font(.largeTitle)
                        .frame(width:200,height:80)
                }
                .buttonStyle(.glass)
                .tint(.black)
            }
            
            
        }.ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
