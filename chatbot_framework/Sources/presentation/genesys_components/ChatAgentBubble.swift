//
//  ChatAgentBubble.swift
//  Chatbot
//
//  Created by badr_hourimeche on 20/9/2024.
//

import SwiftUI

struct ChatAgentBubble: View {
    var userInfos: UserInfos
    var message: MessagesItem

    var body: some View {
        VStack {
            HStack {
                if message.from?.type == .client {
                    UserBubble(message: message)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 16)
                } else {
                    ChatBubble(userInfos: userInfos, message: message)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                }
            }
        }
    }
}

struct ChatBubble: View {
    var userInfos: UserInfos
    var message: MessagesItem
    @Environment(\.locale) var locale

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("icon_agent", bundle: .main)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text(message.from?.nickname?.isEmpty ?? true ? "Agent" : (message.from?.nickname ?? "Agent"))
                    .font(size: 13, weight: .bold, color: "Gray68")
                Text("\("de".localizedString(locale: locale)) \(userInfos.canal)")
                    .font(size: 13, weight: .regular, color: "Gray68")
                Spacer()
                Text(timestampToDate(timestamp: message.utcTime))
                    .font(size: 12, color: "Gray68")
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            Text(message.text ?? "")
                .font(size: 13, color: "Black")
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 16)
        }
        .background(Color.white)
        .clipShape(RoundedCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 8))
    }
}

struct UserBubble: View {
    var message: MessagesItem

    var body: some View {
        VStack(alignment: .trailing) {
            Text(message.text ?? "")
                .font(size: 14, weight: .regular, color: "Purple50")
                .padding(8)
        }
        .background(Color("Purple500", bundle: .main))
        .clipShape(RoundedCorners(corners: [.topLeft, .bottomLeft, .bottomRight], radius: 8))
    }
}

func timestampToDate(timestamp: Int64?, format: String = "HH:mm") -> String {
    guard let timestamp = timestamp else { return "" }
    
    // Convert timestamp (milliseconds) to Date
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp) / 1000)
    
    // Format the Date object to the desired format
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    return dateFormatter.string(from: date)
}
