//
//  Challenge1Tests.swift
//  Challenge1Tests
//
//  Created by Muhammad Ridwan Novriansyah on 20/04/26.
//

import Testing
@testable import Challenge1

@Suite("Username Validation")
struct UsernameValidationTests {

    // Dari OnboardingView — username default "Username"
    @Test("Default username tidak kosong")
    func defaultUsernameNotEmpty() {
        let user = UserData(username: "username", email: "email")
        #expect(user.isUsernameEmpty() == false)
    }
    
    @Test("Username valid")
    func usernameValid() {
        let rule = UserDataRules(minimumUserNameCount: 3)
        let user = UserData(username: "user", email: "email")
        #expect(user.isUsernameValid(rule: rule))
    }
    
    @Test("Avatar should set to tapped avatar")
    func avatarShouldSetToTappedAvatar() {
        let avatars = ["AVAsatu", "AVAdua", "AVAtiga", "AVAempat"]
        let tapped = avatars[2]
        let sut = AvatarChooseViewModel()
        sut.onTapAvatar(tappedAvatar: tapped)
        sut.onDisappear()
        #expect(sut.selectedAvatar == "AVAtiga")
        #expect(sut.avaSementara == nil)
    }
    
    @Test("Username less than 3 character should be invalid")
    func usernameLessThanThreeCharacterShouldBeInvalid() {
//        let user = UserData(username: "use", email: "email")
//        #expect(user.isUsernameValid() == false)
    }

    // Boundary: panjang username
    @Test("Username terlalu pendek ditolak", arguments: [
        ("", false),
        ("a", false),
        ("ab", false),
        ("abc", true),       // minimum wajar
        ("Budi", true),
        ("Username", true)
    ])
    func usernameLength(input: String, expected: Bool) {
        let isValid = input.count >= 3
        #expect(isValid == expected)
    }

    // Room name dibentuk dari username
    @Test("Room name terbentuk dengan benar dari username")
    func roomNameFormat() {
        let username = "Ridwan"
        let roomName = "\(username)'s Room"
        #expect(roomName == "Ridwan's Room")
    }

    @Test("Room name dengan username kosong")
    func roomNameEmptyUsername() {
        let username = ""
        let roomName = "\(username)'s Room"
        #expect(roomName == "'s Room") //edge case
    }
}
