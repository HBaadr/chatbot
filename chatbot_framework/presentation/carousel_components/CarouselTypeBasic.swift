//
//  CarouselTypeBasic.swift
//  Chatbot
//
//  Created by badr_hourimeche on 8/10/2024.
//
import SwiftUI

struct CarouselTypeBasic: View {
    var message: OptionsItem
    @ObservedObject var viewModel: ChatBotViewModel
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        VStack {
            Spacer()
            HStack {
                ImageReader(url: message.image)
                        .frame(width: 48, height: 48)
                        .scaledToFit()
                        .padding(.trailing, 8)
                
                Text(message.title ?? "")
                    .font(size: 14, weight: .medium, color: "Gray700")
                    .disabled(true)
                    .padding(.trailing, 8)
            }
            .padding([.leading, .trailing], 12)
            .padding(.top, 8)
            
            Spacer()
            
            CarouselButton(message: message, isFullWidth: true, viewModel: viewModel)
                .padding([.leading, .trailing], 12)
                .padding(.bottom, 8)
        }
        .frame(width: screenWidth / 1.7)
        .background(Color("Purple50", bundle: .main))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
