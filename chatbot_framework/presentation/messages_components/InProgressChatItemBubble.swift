//
//  InProgressChatItemBubble.swift
//  Chatbot
//
//  Created by badr_hourimeche on 10/12/2024.
//
import SwiftUI

struct InProgressChatItemBubble: View {
    @State private var activeDot = 0

    var body: some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.gray)
                        .opacity(activeDot == index || activeDot > index ? 1 : 0.3)
                        .animation(.easeInOut(duration: 0.3), value: activeDot)
                }
            }
            .padding(16)
            .background(
                Color.white
                    .clipShape(
                        RoundedCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 8)
                    )
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .onAppear {
            startTypingAnimation()
        }
    }

    private func startTypingAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            withAnimation {
                activeDot = (activeDot + 1) % 4
            }
        }
    }
}
