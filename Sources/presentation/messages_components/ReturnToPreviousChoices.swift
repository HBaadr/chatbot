//
//  ReturnToPreviousChoices.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI


struct ReturnToPreviousChoices: View {
    var onReturnPressed: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                onReturnPressed()
            }) {
                Text("retour", bundle: .main)
                    .font(size: 14, weight: .regular, color: "Purple500")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("Purple500", bundle: .main), lineWidth: 1)
                    )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 16)
        .padding(.top, 0)
    }
}
