import SwiftUI
internal import Combine

struct ItungMundur: View {
    let count: Int

    var body: some View {
        ZStack {
            Color.black.opacity(0.65)
                .ignoresSafeArea()

            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.12), lineWidth: 8)
                    .frame(width: 160, height: 160)

                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [Color(hex: "F4736A"), Color(hex: "A855F7")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 6
                    )
                    .frame(width: 160, height: 160)

                Text("\(count)")
                    .font(.system(size: 80, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .id("cd-\(count)")
                    .transition(
                        .asymmetric(
                            insertion: .scale(scale: 1.5).combined(with: .opacity),
                            removal: .scale(scale: 0.3).combined(with: .opacity)
                        )
                    )
            }
        }
    }
}

struct InRoomView: View {

    let roomName: String
    let name: String

    @AppStorage("selectedAvatar") private var selectedAvatar: String = "AVAdua"
    @State private var timeRemaining: Int = 60
    @State private var topic: String = ""
    @FocusState private var isTopic: Bool
    @State private var isReady: Bool = false
    @State private var participantReady: [String: Bool] = [
        "Ayu": false, "Vigo": false, "Sasha": false, "Syafiq": false
    ]
    @State private var participantAvatar: [String: String] = [:]
    @State private var showCountdown: Bool = false
    @State private var countdownValue: Int = 3
    @State private var navigateToDiscussion: Bool = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var allReady: Bool {
        isReady && participantReady.values.allSatisfy { $0 }
    }

    var timeFormatted: String {
        let m = timeRemaining / 60
        let s = timeRemaining % 60
        return String(format: "%d:%02d", m, s)
    }

    var body: some View {
        ZStack {
            Image("ArtBackground")
                .resizable()
                .ignoresSafeArea()
            Color.nPurple
                .opacity(0.85)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        HStack {
                            Spacer()
                            HStack(spacing: 8) {
                                Image(systemName: "clock.fill")
                                    .foregroundStyle(.white)
                                Text(timeFormatted)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.white)
                                    .monospacedDigit()
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Capsule().fill(Color(hex: "F4736A")))
                        }
                        
                        TextField("Enter your topic here...", text: $topic, axis: .vertical)
                            .lineLimit(1...6)
                            .font(.title2.bold())
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .frame(height: 160, alignment: .topLeading)
                            .background(RoundedRectangle(cornerRadius: 18).fill(.white))
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(
                                        isTopic ? Color.blue.opacity(0.6) : Color.gray.opacity(0.2),
                                        lineWidth: 1.5
                                    )
                            )
                            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                            .fontDesign(.rounded)
                            .animation(.easeInOut(duration: 0.2), value: isTopic)
                            .focused($isTopic)

                        VStack(spacing: 8) {
                            HStack {
                                Text("Host")
                                    .font(.title2.weight(.bold))
                                    .fontDesign(.rounded)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            participantRow(imageName: selectedAvatar, name: name, isReady: isReady)
                        }

                        VStack(spacing: 8) {
                            HStack {
                                Text("Participant")
                                    .font(.title2.weight(.bold))
                                    .fontDesign(.rounded)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            ForEach(["Ayu", "Vigo", "Sasha", "Syafiq"], id: \.self) { pName in
                                participantRow(
                                    imageName: participantAvatar[pName] ?? "defaultAvatar",
                                    name: pName,
                                    isReady: participantReady[pName] ?? false
                                )
                            }
                        }
                        .onAppear {
                            let avatars = ["AVAsatu", "AVAdua", "AVAtiga", "AVAempat"]
                            
                            for name in ["Ayu", "Vigo", "Sasha", "Syafiq"] {
                                if participantAvatar[name] == nil {
                                    participantAvatar[name] = avatars.randomElement()
                                }
                            }
                        }

                        Spacer(minLength: 100)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                }

                VStack(spacing: 0) {

                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
                            isReady.toggle()
                        }
                        if isReady {
                            simulateParticipantsReady()
                        } else {
                            for key in participantReady.keys {
                                participantReady[key] = false
                            }
                        }
                    } label: {
                        HStack(spacing: 10) {
                        }
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isReady)
                        
                        Text(isReady ? "Not Ready!" : "I'm Ready")
                            .font(.headline)
                            .fontDesign(.rounded)
                            .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(isReady ? Color.red :
                                        Color.green)
                        )
                    }
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                }

            }

            if showCountdown {
                ItungMundur(count: countdownValue)
                    .transition(.opacity)
            }

            NavigationLink(
                destination: WriteIdeaView(
                    topic: topic,
                    playerName: name
                ),
                isActive: $navigateToDiscussion
            ) {
                EmptyView()
            }
            
        }
        .navigationTitle(roomName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onChange(of: allReady) { ready in
            if ready { mulaiCountdown() }
        }
    }

    func mulaiCountdown() {
        Task { @MainActor in
            withAnimation(.easeInOut(duration: 0.25)) {
                countdownValue = 3
                showCountdown = true
            }

            for tick in stride(from: 2, through: 1, by: -1) {
                try? await Task.sleep(for: .seconds(1))
                withAnimation(.spring(response: 0.4, dampingFraction: 0.55)) {
                    countdownValue = tick
                }
            }

            try? await Task.sleep(for: .seconds(1))
            withAnimation(.easeInOut(duration: 0.25)) { showCountdown = false }

            try? await Task.sleep(for: .milliseconds(300))
            navigateToDiscussion = true
        }
    }

    func simulateParticipantsReady() {
        Task { @MainActor in
            for pName in ["Ayu", "Vigo", "Sasha", "Syafiq"] {
                try? await Task.sleep(for: .milliseconds(700))
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    participantReady[pName] = true
                }
            }
        }
    }
}

@ViewBuilder
func participantRow(imageName: String, name: String, isReady: Bool) -> some View {
    ZStack {
        Capsule()
            .fill(Color.white.opacity(0.1))
            .overlay(
                Capsule()
                    .stroke(Color.white.opacity(0.3), lineWidth: 1.5)
            )
            .frame(height: 52)

        HStack {
            HStack(spacing: 8) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 52, height: 52)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 1.5)
                    )

                Text(name)
                    .font(.title3.weight(.semibold))
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
            }
            Spacer()

            ZStack {
                Circle()
                    .fill(isReady ? Color.green : Color(hex: "F4736A"))
                    .frame(width: 14, height: 14)
                    .shadow(
                        color: isReady ? .green.opacity(0.7) : Color(hex: "F4736A").opacity(0.7),
                        radius: 5
                    )
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isReady)
            .padding(.trailing, 18)
        }
    }
}

#Preview {
    NavigationStack {
        InRoomView(roomName: "Room Diskusi", name: "Syukron")
    }
}
