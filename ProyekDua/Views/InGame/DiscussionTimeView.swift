import SwiftUI
internal import Combine

struct DiscussionTimeView: View {
    
    private var playerName: String = "Ayu"
    private var topic: String = "Dampak AI ke Depan tergantung orangnya"
    
    @State private var timeRemaining: Int = 60
    @State private var timerActive = false
    @State private var showHeader = false
    @State private var avatar = false
    @State private var showBody = false
    @State private var showConfetti = false
    @State private var goToGameDone = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var timeFormatted: String {
        let m = timeRemaining / 60
        let s = timeRemaining % 60
        return String(format: "%d:%02d", m, s)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("ArtBackground")
                .resizable()
                .ignoresSafeArea()
            
            Color.nPurple
                .opacity(0.85)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                VStack {
                    Text("Discussion Time !!")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white)
                    
                    HStack(spacing: 8) {
                        Text("It's")
                            .foregroundStyle(.white)
                        
                        Text("\(playerName) Turn")
                            .foregroundColor(Color(hex: "781DFF"))
                            .fontDesign(.rounded)
                            .shadow(color: .white, radius: 3)
                            .shadow(color: .black.opacity(0.25), radius: 6, y: 6)
                    }
                    .font(.system(size: 36, weight: .bold))
                    
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#C084FC").opacity(0.4))
                            .frame(width: 220, height: 220)
                        
                        Image("AVAdua")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                    }
                    .scaleEffect(avatar ? 1 : 0.3)
                    .opacity(avatar ? 1 : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: avatar)
                }
                .opacity(showHeader ? 1 : 0)
                .offset(y: showHeader ? 0 : -30)
                .animation(.easeOut(duration: 0.5), value: showHeader)
                .padding(.bottom, 28)
            
                VStack(spacing: 36){
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Say What???")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.white)
                        
                        Text(topic)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(.nPurple)
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(Color.white.opacity(0.25))
                            .clipShape(Circle())
                        
                        Text(timeFormatted)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.white)
                            .monospacedDigit()
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 14)
                    .background(
                        Capsule().fill(Color(hex: "#FF5D7E"))
                    )
                    
                    Text("Every idea counts, so listen up! Great insights\ncan come from anyone!")
                        .font(.system(size: 16, weight: .medium))
                        .italic()
                        .foregroundStyle(.white.opacity(0.75))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 32)
                }
                .opacity(showBody ? 1 : 0)
                .offset(y: showBody ? 0 : 30)
                .animation(.easeOut(duration: 0.5), value: showBody)
            }
        }
        
        .overlay {
            if showConfetti {
                ConfettiView()
                    .ignoresSafeArea()
                    .transition(.opacity)
            }
        }
        .onReceive(timer) { _ in
            guard timerActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timerActive = false
                
                withAnimation {
                    goToGameDone = true
                }
            }
        }
        .navigationDestination(isPresented: $goToGameDone) {
            GameDoneView()
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await runAnimationSequence()
        }
    }
}

extension DiscussionTimeView {
    
    func runAnimationSequence() async {
        
        try? await Task.sleep(for: .seconds(1))
        withAnimation {
            showHeader = true
        }
        
        try? await Task.sleep(for: .seconds(1))
        withAnimation {
            showConfetti = true
        }
        
        try? await Task.sleep(for: .seconds(1))
        avatar = true
        
        try? await Task.sleep(for: .seconds(1))
        withAnimation {
            showBody = true
            timerActive = true
        }
        
        try? await Task.sleep(for: .seconds(1))
        withAnimation {
            showConfetti = false
        }
    }
}

#Preview {
    DiscussionTimeView(
    )
}
