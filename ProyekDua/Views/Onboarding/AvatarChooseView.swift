//
//  AvatarChooseView.swift
//  Challenge1
//
//  Created by Muhammad Ridwan Novriansyah on 22/04/26.
//

import SwiftUI

struct UserDataRules {
    let minimumUserNameCount: Int
    
    init(minimumUserNameCount: Int) {
        self.minimumUserNameCount = minimumUserNameCount
    }
}

struct UserData: Codable {
    var username: String
    let email: String
    
    func isUsernameEmpty() -> Bool {
        username.isEmpty
    }
    
    func isUsernameValid(rule: UserDataRules) -> Bool {
        username.count > rule.minimumUserNameCount
    }
    
    func isEmailEmpty() -> Bool {
        email.isEmpty
    }
}

struct AvatarChooseView: View {
    
    @Binding var selectedAvatar: String
    @Environment(\.dismiss) private var dismiss
    @State private var avaSementara: String
    
    let avatars = [
        "AVAsatu", "AVAdua", "AVAtiga",
        "AVAempat", "AVAlima", "AVAenam"
    ]
    
    init(selectedAvatar: Binding<String>) {
        self._selectedAvatar = selectedAvatar
        self._avaSementara = State(initialValue: selectedAvatar.wrappedValue)
    }
    
    var body: some View {
        ZStack {
            Image("ArtBackground").resizable().ignoresSafeArea()
            Color.nPurple.opacity(0.85).ignoresSafeArea()
            
            VStack(spacing: 36) {
                AvatarView(imageName: avaSementara, size: 200, stroke: 8)
                    .animation(.spring(duration: 0.3), value: avaSementara)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    
                    ForEach(avatars, id: \.self) { avatar in
                        AvatarView(
                            imageName: avatar,
                            size: 95,
                            stroke: avatar == avaSementara ? 5 : 3
                        )
                        .overlay(
                            Circle().stroke(
                                avatar == avaSementara ? Color.yellow : Color.clear,
                                lineWidth: 4
                            )
                        )
                        .onTapGesture {
                            avaSementara = avatar
                        }
                    }
                }
                .padding(20)
                
                Spacer()
            }
            .padding(.top, 24)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Avatar")
                    .font(.largeTitle.weight(.bold))
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
            }
        }
        .onDisappear {
            selectedAvatar = avaSementara
        }
    }
}

class AvatarChooseViewModel {
    var selectedAvatar: String? = "Default"
    var avaSementara: String?
    
    func onTapAvatar(tappedAvatar: String) {
        avaSementara = tappedAvatar
    }
    
    func onDisappear() {
        selectedAvatar = avaSementara
        avaSementara = nil
    }
}

struct AvatarView: View {
    let imageName: String
    let size: CGFloat
    let stroke: CGFloat
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: stroke)
            )
            .shadow(radius: 5)
    }
}

#Preview {
    AvatarChooseView(selectedAvatar: .constant("AVAdua"))
}
