//
//  File.swift
//  
//
//  Created by badr_hourimeche on 11/9/2024.
//
import SwiftUI

struct TypewriterText: View {
    @AppStorage("typewriterTextDisplayedInSession") private var textDisplayedInSession: Bool = false
    @State private var textToDisplay: String = ""
    
    let text: String
    
    var body: some View {
        Text(textDisplayedInSession ? text : textToDisplay)
            .font(size: 14, weight: .regular, color: "Gray500")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .onAppear {
                // Check if the animation has already run in this session
                if !textDisplayedInSession {
                    typeText()
                }
            }
    }
    
    private func typeText() {
        Task {
            for charIndex in 0..<text.count {
                let endIndex = text.index(text.startIndex, offsetBy: charIndex + 1)
                textToDisplay = String(text[..<endIndex])
                try await Task.sleep(nanoseconds: 30_000_000) // 30ms delay
            }
            // Mark as displayed for the session
            textDisplayedInSession = true
        }
    }
}
