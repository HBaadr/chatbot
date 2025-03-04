//
//  CarouselTypeCard.swift
//  Chatbot
//
//  Created by badr_hourimeche on 8/10/2024.
//

import SwiftUI

struct CarouselTypeCard: View {
    let message: OptionsItem
    let screenWidth = UIScreen.main.bounds.width
    let viewModel: ChatBotViewModel
    @Environment(\.locale) var locale

    var body: some View {
        HStack(spacing: 0) {
            // Left Column
            VStack(alignment: .leading, spacing: 0) {
                
                ImageReader(url: message.image)
                        .frame(width: 24, height: 24)
                        .scaledToFit()
                        .padding([.leading, .top], 8)

                Text(message.title ?? "")
                    .font(size: 12, weight: .semibold, color: "Inwi500", spacing: 4)
                    .frame(width: screenWidth / 2.8, alignment: .leading)
                    .padding([.leading, .trailing, .top], 8)
                
                Spacer()
                
                Text(message.packageStar ?? "")
                    .font(size: 16, weight: .semibold, color: "White")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(hex: 0xFFE86E00), Color(hex: 0xFFFFC107)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(5)
                    .padding(.bottom, 8)
                    .padding(.horizontal, 8)
            }
            .frame(maxHeight: .infinity)
            .background(Color.white)
            .clipShape(
                CustomRoundedRectangle(
                    bottomLeadingRadius: locale.identifier == "ar" ? 0 : 12,
                    bottomTrailingRadius: locale.identifier == "ar" ? 12 : 0
                )
            )
            .background(Color("Inwi500", bundle: .main))

            // Right Column
            VStack(alignment: .center, spacing: 0) {
                Image("icon_inwi_logo", bundle: .main)
                    .resizable()
                    .frame(width: 52, height: 13)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 16)
                    .padding(.horizontal, 8)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .background(Color("Inwi500", bundle: .main))
            .clipShape(
                CustomRoundedRectangle(
                    topLeadingRadius: locale.identifier == "ar" ? 12 : 0,
                    topTrailingRadius: locale.identifier == "ar" ? 0 : 12
                )
            )
        }
        .frame(maxWidth: screenWidth / 1.7, maxHeight: .infinity)
        .roundedCornerWithBorder(lineWidth: 2, borderColor: Color("Inwi500", bundle: .main), radius: 12, corners: [.allCorners])
        .padding(.top, 2)
        .onTapGesture {
            redirect(message: message, viewModel: viewModel)
        }
    }
}

