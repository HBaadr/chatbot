//
//  SatisfactionIdleView.swift
//  Chatbot
//
//  Created by badr_hourimeche on 8/10/2024.
//
import SwiftUI

struct SatisfactionIdleView: View {
    
    let userInfos: UserInfos
    let date: String
    let onYesPressed: () -> Void
    let onNoPressed: () -> Void
    @Environment(\.locale) var locale

    var body: some View {
        VStack {
            HStack {
                Image("icon_bot", bundle: .main)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text("bot", bundle: .main)
                    .font(size: 13, weight: .bold, color: "Gray68")
                Text("\("de".localizedString(locale: locale)) \(userInfos.canal)")
                    .font(size: 13, weight: .regular, color: "Gray68")
                Spacer()
                Text(date)
                    .font(size: 12, weight: .medium, color: "Gray68")
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)

            Text("we_helped_you", bundle: .main)
                .font(size: 13, weight: .regular, color: "Black")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)

            HStack(spacing: 16) {
                Button(action: {
                    onYesPressed()
                }) {
                    Text("oui", bundle: .main)
                        .font(
                            size: 16,
                            weight: .regular,
                            color: "Inwi500"
                        )
                        .padding(.vertical, 8)
                        .background(Color.clear)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Inwi500", bundle: .main), lineWidth: 1)
                        )
                        .frame(maxWidth: .infinity)
                }
                
                Button(action: {
                    onNoPressed()
                }) {
                    Text("non", bundle: .main)
                        .font(
                            size: 16,
                            weight: .regular,
                            color: "Inwi500"
                        )
                        .padding(.vertical, 8)
                        .background(Color.clear)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Inwi500", bundle: .main), lineWidth: 1)
                        )
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .cornerRadius(8)
    }
}
