import SwiftUI

struct TimesUpView: View {
    
    @State private var emotAtas = false
    @State private var showTitle = false
    @State private var emotBawah = false
    @State private var showConfetti = false
    @State private var goNext = false
    @AppStorage("username") private var storedUsername: String = "Guest"
    
    let playerName: String
    let topic: String
    
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
            VStack{
                VStack {
                    HStack {
                        Spacer()
                        Text("🫢")
                            .font(.system(size: 90))
                            .scaleEffect(emotAtas ? 1 : 0.3)
                            .opacity(emotAtas ? 1 : 0)
                            .offset(x: 10, y: emotAtas ? 0 : -30)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6), value: emotAtas)
                    }
                }
                .padding(.top, 180)
                .rotationEffect(.degrees(10))
                
                VStack(spacing: 0) {
                    HStack(alignment: .bottom, spacing: 6) {
                        VStack(alignment: .leading, spacing: -8) {
                            
                            HStack(alignment: .center, spacing: 6) {
                                Text("TIMES")
                                    .font(.system(size: 64, weight: .heavy))
                                    .foregroundColor(Color(hex: "781DFF"))
                                    .shadow(color: .white, radius: 3)
                                    .shadow(color: .white, radius: 3)
                                    .fontDesign(.rounded)
                                    .shadow(
                                        color: .black.opacity(0.25),
                                        radius: 6,
                                        x: 0,
                                        y: 6
                                    )
                                
                                
                                Image(systemName: "clock")
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundStyle(.white)
                                    .offset(y: 4)
                            }
                            
                            HStack {
                                Spacer()
                                Text("UP!")
                                    .font(.system(size: 64, weight: .heavy))
                                    .foregroundStyle(.white)
                                    .fontDesign(.rounded)
                                    .shadow(
                                        color: .purple.opacity(0.8),
                                        radius: 2,
                                        x: 2,
                                        y: 2
                                    )
                            }
                        }
                    }
                    .scaleEffect(showTitle ? 1 : 0.6)
                    .opacity(showTitle ? 1 : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: showTitle)
                }
                
                VStack {
                    HStack {
                        Text("🥳")
                            .font(.system(size: 90))
                            .scaleEffect(emotBawah ? 1 : 0.3)
                            .opacity(emotBawah ? 1 : 0)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6), value: emotBawah)
                        Spacer()
                    }
                }
                .padding(.bottom, 180)
                .offset(x:30, y:-80)
                .rotationEffect(.degrees(-10))
            }
            .padding(.horizontal, 40)
        }
        .task {
            await runAnimationSequence()
        }
        .navigationDestination(isPresented: $goNext) {
            YourTurnView(
                playerName: playerName,
                topic: topic 
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}
    
extension TimesUpView {
        
        func runAnimationSequence() async {
            
            try? await Task.sleep(for: .seconds(1))
            withAnimation {
                emotAtas = true
            }
            
            try? await Task.sleep(for: .seconds(1))
            withAnimation {
                showConfetti = true
            }
            
            try? await Task.sleep(for: .seconds(1))
            showTitle = true
            
            try? await Task.sleep(for: .seconds(1))
            withAnimation {
                emotBawah = true
            }
            
            try? await Task.sleep(for: .seconds(1))
            withAnimation {
                showConfetti = false
                
            }
            
            try? await Task.sleep(for: .seconds(1))
            goNext = true
        }
    }

#Preview {
    TimesUpView(
        playerName: "Ayu",
        topic: "AI will replace jobs"
    )
}
