//
//  ChatHeader.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI

struct ChatHeader: View {
    var showBackButton: Bool = false
    var onBackPressed: () -> Void
    @Environment(\.layoutDirection) var layoutDirection

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if showBackButton {
                Button(action: {
                    onBackPressed()
                }) {
                    Image(systemName: layoutDirection == .leftToRight ? "arrow.left" : "arrow.right")
                        .foregroundColor(Color("Purple500", bundle: .main))
                        .frame(width: 24, height: 24)
                }
                .transition(.opacity)
            }
            
            Text("t_chat", bundle: .main)
                .font(size: 18, weight: .semibold, color: "Purple500")
                .padding(.horizontal, showBackButton ? 8 : 16)
            
            Spacer()
            
            if !showBackButton {
                Button(action: {
                    onBackPressed()
                }) {
                    Text("fermer_la_conversation", bundle: .main)
                        .font(size: 14, weight: .semibold, color: "Inwi500")
                        .background(Color.clear)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color("Inwi500", bundle: .main), lineWidth: 2)
                        )
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
    }
}
