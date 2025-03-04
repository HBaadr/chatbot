//
//  SatisfactionBarView.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI


struct SatisfactionBarView: View {
    var userInfos: UserInfos
    @ObservedObject var viewModel: ChatBotViewModel
    @Environment(\.locale) var locale

    var body: some View {
        VStack {
            // Chat bubble
            VStack {
                HStack {
                    Image("icon_bot", bundle: .main)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("bot", bundle: .main)
                        .font(size: 13, weight: .bold, color: "Gray68")
                        .padding(.leading, 8)
                    Text("\("de".localizedString(locale: locale)) \(userInfos.canal)")
                        .font(size: 13, weight: .regular, color: "Gray68")
                        .padding(.leading, 4)
                    Spacer()
                    Text(getCurrentTime())
                        .font(size: 12, weight: .medium, color: "Gray68")
                }
                .padding([.leading, .trailing, .top], 16)
                
                Text("good_answer", bundle: .main)
                    .font(size: 13, weight: .regular, color: "Black")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                RatingBar(onRatingSelected: { rating in
                    viewModel.refresh()
                    viewModel.sendUserSatisfaction(isUserSatisfied: true, rating: rating)
                })
                .padding([.leading, .trailing], 16)
                .padding(.top, 8)
                .padding(.bottom, 16)
            }
            .background(Color.white)
            .cornerRadius(8)
        }
    }
    
    // Helper function to get the current time as a string
    private func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: Date())
    }
}
