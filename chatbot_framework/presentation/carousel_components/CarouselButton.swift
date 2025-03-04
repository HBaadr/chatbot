//
//  CarouselButton.swift
//  Chatbot
//
//  Created by badr_hourimeche on 8/10/2024.
//

import SwiftUI


struct CarouselButton: View {
    var message: OptionsItem
    var isFullWidth: Bool = false
    @ObservedObject var viewModel: ChatBotViewModel
    
    var body: some View {
        Button(action: {
            redirect(message: message, viewModel: viewModel)
        }) {
            Text(message.buttonText ?? "")
                .font(size: 16, weight: .medium, color: "White")
                .padding(12)
                .frame(maxWidth: isFullWidth ? .infinity : .none)
                .background(Color("Inwi500", bundle: .main))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
