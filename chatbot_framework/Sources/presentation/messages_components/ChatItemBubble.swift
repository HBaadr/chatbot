//
//  ChatItemBubble.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI


struct ChatItemBubble<Content: View>: View {
    var userInfos: UserInfos
    var message: MessageItem
    @ViewBuilder let content: () -> Content
    @Environment(\.locale) var locale

    var body: some View {
        VStack {
            VStack {
                if message.isUser != true {
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
                        if let messageDate = message.messageDate {
                            Text(formatDateTime(dateTimeString: messageDate))
                                .font(size: 12, weight: .medium, color: "Gray68")
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                }
                
                let text = if message.text != nil{
                    Text(message.text!.trimmingCharacters(in: CharacterSet.newlines))
                } else {
                    Text("choose_choice", bundle: .main)
                }
                text
                    .font(
                        size: message.isUser == true ? 14 : 13,
                        weight: .regular,
                        color: message.isUser == true ? "Purple50" : "Black"
                    )
                    .padding(.horizontal, message.isUser == true ? 8 : 16)
                    .padding(.bottom, message.isUser == true ? 8 : 16)
                    .padding(.top, message.isUser == true ? 8 : 0)
                    .frame(maxWidth: message.isUser == true ? .none : .infinity, alignment: .leading)
                
                if let externalLink = message.action {
                    Button(action: {
                        redirect(message: message)
                    }) {
                        let text2 = if message.buttonText != nil{
                            Text(message.buttonText!)
                        } else {
                            Text("je_d_couvre", bundle: .main)
                        }
                        text2
                            .font(size: 13, weight: .medium, color: "Inwi500")
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(Color("Inwi50", bundle: .main))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }.padding([.horizontal, .bottom], 16)
                }
                content()
            }
            .background(message.isUser == true ? Color("Purple500", bundle: .main) : Color.white)
            .clipShape(RoundedCorners(corners: message.isUser == true ? [.topLeft, .bottomLeft, .bottomRight] : [.topRight, .bottomLeft, .bottomRight], radius: 8))
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, alignment: message.isUser == true ? .trailing : .leading)
    }
}

func formatDateTime(dateTimeString: String?) -> String {
    guard let dateTimeString = dateTimeString else { return "" }
    
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    
    if let date = inputFormatter.date(from: dateTimeString) {
        // Add one hour to the parsed date
        let calendar = Calendar.current
        if let datePlusOneHour = calendar.date(byAdding: .hour, value: 1, to: date) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            return outputFormatter.string(from: datePlusOneHour)
        }
    }
    
    return ""
}


