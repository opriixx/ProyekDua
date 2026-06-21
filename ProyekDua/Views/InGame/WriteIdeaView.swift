//
//  WriteIdeaView.swift
//  Challenge1
//
//  Created by Muhammad Ridwan Novriansyah on 22/04/26.
//

import SwiftUI
internal import Combine

struct WriteIdeaView: View {
    let topic: String
    let playerName: String
    @State private var timeRemaining: Int = 60
    @State private var answer: String = ""
    @State private var goToTurn = false
    @State private var showTimesUp = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
            Rectangle()
                .fill(Color(hex: "260669"))
                .rotationEffect(.degrees(120))
                .offset(y: -500)
                .opacity(0.5)
            
            VStack(spacing: 24) {
                VStack(spacing: 16){
                    HStack {
                        HStack{
                            Text("Write Your Idea")
                                .font(.system(.largeTitle, weight: .bold))
                                .foregroundStyle(.white)
                                .fontDesign(.rounded)
                        }
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
                    
                    VStack(spacing: 16) {
                        Text("Topic")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .fontDesign(.rounded)
                        
                        Text(topic.isEmpty ? "No topic yet..." : topic)
                            .font(.title2.bold())
                            .foregroundColor(topic.isEmpty ? .gray : .black)
                            .fontDesign(.rounded)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .frame(minHeight: 160, alignment: .topLeading)
                            .background(
                                RoundedRectangle(cornerRadius:16)
                                    .fill(Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1.5)
                            )
                            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                            .fontDesign(.rounded)
                    }
                }
                VStack(alignment: .leading, spacing: 16) {
                        Text("Your Answer")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .fontDesign(.rounded)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.green)
                            .clipShape(Capsule())
                        
                        TextField("Write your answer...", text: $answer, axis: .vertical)
                            .lineLimit(3...20)
                            .font(.callout)
                            .fontDesign(.rounded)
                            .foregroundColor(.black)
                            .padding(16)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.nPurple.opacity(0.9), lineWidth: 2.5)
                            )
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                showTimesUp = true
            }
        }
        .navigationDestination(isPresented: $showTimesUp) {
            TimesUpView(
                playerName: playerName,
                topic: answer
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WriteIdeaView(
        topic: "AI will replace jobs",
        playerName: "Ayu"
    )
}
