//
//  ConfettiView.swift
//  Challenge1
//
//  Created by Muhammad Ridwan Novriansyah on 21/04/26.
//

import SwiftUI

struct ConfettiParticle: Identifiable {
    let id = UUID()
    
    var x: CGFloat = .random(in: 0...1)
    var y: CGFloat = -0.1
    var size: CGFloat = .random(in: 6...12)
    var rotation: Double = .random(in: 0...360)
    var duration: Double = .random(in: 2...4)
    var color: Color = [.red, .yellow, .blue, .green, .pink].randomElement()!
    
    mutating func start() {
        y = 1.2
    }
}

struct ConfettiView: View {
    @State private var particles: [ConfettiParticle] = (0..<30).map { _ in ConfettiParticle() }
    
    var body: some View {
        GeometryReader { geo in
            ForEach(particles) { particle in
                Rectangle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size)
                    .position(x: particle.x * geo.size.width,
                              y: particle.y * geo.size.height)
                    .rotationEffect(.degrees(particle.rotation))
                    .animation(.linear(duration: particle.duration).repeatForever(autoreverses: false), value: particle.y)
            }
        }
        .onAppear {
            for i in particles.indices {
                particles[i].start()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ConfettiView()
}
