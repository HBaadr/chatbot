//
//  CarouselTypeBanner.swift
//  Chatbot
//
//  Created by badr_hourimeche on 8/10/2024.
//

import SwiftUI

struct CarouselTypeBanner: View {
    var message: OptionsItem
    @ObservedObject var viewModel: ChatBotViewModel
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        ZStack(alignment: .bottomLeading) {
            ImageReader(url: message.image)
                .frame(width: screenWidth / 1.3, height: screenWidth / 2.5)
                .scaledToFill()
            
            CarouselButton(message: message, viewModel: viewModel)
                .padding(12)
        }
        .frame(width: screenWidth / 1.3, height: screenWidth / 2.5)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .roundedCornerWithBorder(lineWidth: 1, borderColor: Color("Gray200", bundle: .main), radius: 12, corners: [.allCorners])
    }
}
