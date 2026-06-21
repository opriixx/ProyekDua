import SwiftUI


struct GameDoneView: View {
    
    @State private var showEmoji = false
    @State private var showTitle = false
    @State private var showSubtitle = false
    @State private var showConfetti = false
    
    var body: some View {
        ZStack {
            Image("ArtBackground")
                .resizable()
                .ignoresSafeArea()
            Color.nPurple
                .opacity(0.9)
                .ignoresSafeArea()

            if showConfetti {
                ConfettiView()
            }
            
            VStack(spacing: 16) {
                Spacer()
                Text("🥳")
                    .font(.system(size: 100))
                    .scaleEffect(showEmoji ? 1 : 0.3)
                    .opacity(showEmoji ? 1 : 0)
                    .offset(y: showEmoji ? 0 : -20)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: showEmoji)

                HStack(spacing: 10) {
                    Text("It's")
                    
                    Text("Done")
                        .foregroundColor(Color(hex: "781DFF"))
                        .shadow(color: .white, radius: 1)
                        .shadow(color: .white, radius: 1)
                }
                .font(.system(size: 64, weight: .bold))
                .foregroundStyle(.white)
                .fontDesign(.rounded)
                .padding(.horizontal, 20)
                .shadow(
                    color: .black.opacity(0.25),
                    radius: 6,
                    x: 0,
                    y: 6
                )
                .scaleEffect(showTitle ? 1 : 0.6)
                .opacity(showTitle ? 1 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: showTitle)

                VStack(spacing: 4) {
                    Text("You did a great job!")
                    Text("Keep Practicing")
                }
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.white)
                .fontDesign(.rounded)
                .padding(.horizontal, 20)
                .shadow(
                    color: .black.opacity(0.25),
                    radius: 6,
                    x: 0,
                    y: 6
                )
                .opacity(showSubtitle ? 1 : 0)
                .offset(y: showSubtitle ? 0 : 20)
                .animation(.easeOut(duration: 0.4), value: showSubtitle)
                
                Spacer()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await playAnimation()
        }
    }
}

extension GameDoneView {
    
    func playAnimation() async {
        try? await Task.sleep(for: .seconds(0.5))
        withAnimation {
            showEmoji = true
        }
        
        try? await Task.sleep(for: .seconds(0.5))
        withAnimation {
            showConfetti = true
        }
        
        try? await Task.sleep(for: .seconds(0.5))
        withAnimation {
            showTitle = true
        }
        
        try? await Task.sleep(for: .seconds(0.5))
        withAnimation {
            showSubtitle = true
        }
        
        try? await Task.sleep(for: .seconds(3))
        withAnimation {
            showConfetti = false
        }
    }
}


#Preview {
    GameDoneView()
}


