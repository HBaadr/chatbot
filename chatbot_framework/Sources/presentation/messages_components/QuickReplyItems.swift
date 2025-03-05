//
//  QuickReplyItems.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI


struct QuickReplyItems: View {
    var options: [OptionsItem]
    var viewModel: ChatBotViewModel
    @Environment(\.locale) var locale

    var body: some View {
        FlowLayout(mode: .scrollable, items: options, itemSpacing: 4) { item in
            Button(action: {
                let params: [FirebaseParam: String?] = [
                    .contenu: item.tag,
                    .typeOptionsChatbot: item.actionType?.rawValue
                ]
                FirebaseModule.logEvent(event: .event_MI1414, parameters: params)
                viewModel.addUserText(option: item)
            }) {
                Text(item.title ?? "")
                    .font(size: 14, weight: .regular, color: "Purple500")
                    .padding()
                    .background(Color("Purple50", bundle: .main))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .environment(\.layoutDirection,locale.identifier == "ar" ? .leftToRight : .rightToLeft)
    }
}
