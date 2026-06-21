import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}



struct OnboardingView: View {
    @State private var username: String = "Username"
    @State private var userData: UserData = UserData(username: "Username", email: "")
    @State private var navigateInRoom = false
    @FocusState private var isUsernameFocused: Bool
    @AppStorage("selectedAvatar") private var selectedAvatar: String = "AVAdua"
    
    var body: some View {
        NavigationStack{
            ZStack {
                Image("ArtBackground")
                    .resizable()
                    .ignoresSafeArea()
                
                Color.nPurple
                    .opacity(0.9)
                    .ignoresSafeArea()
                
                VStack{
                    VStack(spacing: 40) {
                        VStack(spacing: 0) {
                            Text("Let's")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Create")
                                .foregroundColor(Color(hex: "781DFF"))
                                .shadow(color: .white, radius: 1)
                                .shadow(color: .white, radius: 1)
                            
                            Text("Avatar!")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .font(.system(size: 64, weight: .semibold))
                        .foregroundStyle(.white)
                        .fontDesign(.rounded)
                        .padding(.horizontal, 20)
                        .shadow(
                            color: .black.opacity(0.25),
                            radius: 6,
                            x: 0,
                            y: 6
                        )
                        
                        VStack {
                            ZStack(alignment: .bottomTrailing) {
                                
                                Image(selectedAvatar)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 220, height: 220)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)

                                NavigationLink(destination: AvatarChooseView(selectedAvatar: $selectedAvatar)) {
                                    Image(systemName: "pencil")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(Color.nPurple)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 4))
                                        .shadow(radius: 4)
                                }
                                .offset(x: -10, y: -5)
                            }
                            
                            Spacer()
                        }
                        
                        VStack(spacing: 8) {
                            Text("Nickname")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(.white)
                                .fontDesign(.rounded)
                            HStack {
                                TextField(
                                    "Username",
                                    text: $username
                                )
                                .foregroundStyle(.white)
                                .foregroundColor(.white)
                                

                                
                                Image(systemName: "die.face.5.fill")
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .padding()
                            .fontDesign(.rounded)
                            .background(
                                .ultraThinMaterial,
                                in: RoundedRectangle(cornerRadius: 18, style: .continuous)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(
                                        isUsernameFocused
                                        ? .white.opacity(0.6)
                                        : .white.opacity(0.2),
                                        lineWidth: 1.5
                                    )
                            )
                            .shadow(
                                color: .black.opacity(0.25),
                                radius: 12,
                                x: 0,
                                y: 6
                            )
                            .animation(.easeInOut(duration: 0.2), value: isUsernameFocused)
                            .focused($isUsernameFocused)
                        }
                        .padding(.horizontal, 20)
                    }
                    
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
                    }
                    .padding(.vertical, 40)
                    .navigationDestination(isPresented: $navigateInRoom) {
                        InRoomView(
                            roomName: "\(username)'s Room",
                            name: username
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
