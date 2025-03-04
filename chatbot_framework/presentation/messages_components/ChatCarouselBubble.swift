//
//  ChatCarouselBubble.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI


struct ChatCarouselBubble: View {
    var userInfos: UserInfos
    var message: MessageItem
    @ObservedObject var viewModel: ChatBotViewModel
    
    var body: some View {
        ChatItemBubble(userInfos: userInfos, message: message) {
            Divider()
                .background(Color("Gray200", bundle: .main))
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .padding(.top, 0)
            
            CarouselItems(message: message, viewModel: viewModel)
                .padding(.horizontal, 14)
                .padding(.bottom, 14)
        }
    }
}


struct CarouselItems: View {
    var message: MessageItem
    @ObservedObject var viewModel: ChatBotViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(message.options ?? [], id: \.idd) { option in
                    switch message.type {
                    case .carousel_card:
                        CarouselTypeCard(message: option, viewModel: viewModel)
                    case .carousel_banner:
                        CarouselTypeBanner(message: option, viewModel: viewModel)
                    case .carousel_package:
                        CarouselTypePackage(message: option, viewModel: viewModel)
                    default:
                        CarouselTypeBasic(message: option, viewModel: viewModel)
                    }
                }
            }
            .padding(.horizontal, 2)
            .padding(.bottom, 2)
        }
    }
}
