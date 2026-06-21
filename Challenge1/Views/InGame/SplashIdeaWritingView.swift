import SwiftUI

struct SplashIdeaWritingView: View {
    @State private var navigateInRoom = false
    
    @State private var showHeader = false
    @State private var showBubble = false
    @State private var showCharacter = false
    @State private var showButton = false
    @State private var showConfetti = false
    
    var body: some View {
        ZStack {
            Image("ArtBackground")
                .resizable()
                .ignoresSafeArea()
            
            Color.nPurple
                .opacity(0.9)
                .ignoresSafeArea()
            
            Circle()
                .fill(Color.white.opacity(0.05))
                .frame(width: 300, height: 300)
                .offset(x: 120, y: 300)
            
            VStack(spacing: 20) {
                Spacer()
                
                VStack {
                    VStack(spacing: 12) {
                        Text("Next step...")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white.opacity(0.8))
                            .font(.headline)
                        
                        Text("Idea Writing")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        
                        HStack(spacing: 8) {
                            Image(systemName: "clock.fill")
                                .foregroundStyle(.white)
                            Text("5:00")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                                .monospacedDigit()
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Color(hex: "F4736A")))
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                VStack {
                    ZStack {
                        Image(systemName: "bubble.left.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Text("Time will be given 5 mins, be confident and be humble when answering.")
                            .font(.headline.weight(.semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: 400)
                            .padding(.horizontal, 120)
                            .padding(.bottom, 20)
                    }
                    .frame(width: 400, height: 200)
                    .opacity(showBubble ? 1 : 0)
                    .offset(x: showBubble ? 64 : 120, y: showBubble ? 50 : 80)
                    .animation(.easeOut(duration: 0.5), value: showBubble)
                    
                    Image("emotSplashIdea")
                        .resizable()
                        .frame(width: 276, height: 276)
                        .foregroundColor(.white)
                        .padding(.top, -20)
                        .rotationEffect(.degrees(-6))
                        .offset(x: -50)
                        .scaleEffect(showCharacter ? 1 : 0.5)
                        .opacity(showCharacter ? 1 : 0)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: showCharacter)
                }
                .padding(.top, -64)
                
                Spacer()
                
                Button {
                    navigateInRoom = true
                } label: {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Color.white)
                        .foregroundColor(Color(hex: "481892"))
                        .cornerRadius(40)
                        .font(.system(size: 20, weight: .semibold))
                        .fontDesign(.rounded)
                        .padding(.horizontal, 20)
                        .opacity(showButton ? 1 : 0)
                        .offset(y: showButton ? 0 : 40)
                        .animation(.easeOut(duration: 0.5), value: showButton)
                }
                .padding(.vertical, 40)
            }
            .opacity(showHeader ? 1 : 0)
            .offset(y: showHeader ? 0 : -30)
            .animation(.easeOut(duration: 0.5), value: showHeader)
        }
        
        .overlay {
            if showConfetti {
                ConfettiView()
                    .ignoresSafeArea()
                    .transition(.opacity.combined(with: .scale))
            }
        }
        
        .navigationDestination(isPresented: $navigateInRoom) {
            WriteIdeaView(
                topic: "AI berdampak pada pekerja berpenghasilan rendah...",
                playerName: "Ayu"
            )
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await runAnimationSequence()
        }
    }
}

extension SplashIdeaWritingView {
    
    func runAnimationSequence() async {
        
        try? await Task.sleep(for: .seconds(0.5))
        withAnimation {
            showHeader = true
        }
        
        try? await Task.sleep(for: .seconds(0.8))
        withAnimation {
            showBubble = true
        }
        
        try? await Task.sleep(for: .seconds(0.5))
        withAnimation {
            showCharacter = true
        }
        
        try? await Task.sleep(for: .seconds(0.5))
        withAnimation {
            showConfetti = true
            showButton = true
        }
        
        try? await Task.sleep(for: .seconds(2))
        withAnimation {
            showConfetti = false
        }
    }
}

#Preview {
    NavigationStack {
        SplashIdeaWritingView()
    }
}
