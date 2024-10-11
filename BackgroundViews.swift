//
//  BackgroundViews.swift
//  Eternai
//
//  Created by Monica Shen on 2024-10-02.
//


import SwiftUI

struct StarryBackgroundView: View {
    let starCount: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0.05, green: 0.05, blue: 0.15).edgesIgnoringSafeArea(.all)
                ForEach(0..<starCount, id: \.self) { _ in
                    Star()
                        .position(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        )
                }
            }
        }
    }
}

struct Star: View {
    @State private var opacity: Double = Double.random(in: 0.1...0.7)
    
    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: 2, height: 2)
            .opacity(opacity)
            .animation(
                Animation.easeInOut(duration: Double.random(in: 1...3))
                    .repeatForever()
                    .delay(Double.random(in: 0...2)),
                value: opacity
            )
            .onAppear {
                opacity = Double.random(in: 0.1...0.7)
            }
    }
}

