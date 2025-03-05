//
//  OtherQuestions.swift
//  Chatbot
//
//  Created by badr_hourimeche on 26/9/2024.
//

import SwiftUI


struct OtherQuestions: View {
    @ObservedObject var viewModel: ChatBotViewModel
    @State var showOtherQuestions = false
    
    var body: some View {
        if viewModel.messages.last?.custom?.survey_options?.isEmpty == false {
            if showOtherQuestions {
                QuickReplyItems(options: viewModel.messages.last?.custom?.survey_options ?? [], viewModel: viewModel)
                    .padding(.horizontal, 12)
                    .padding(.leading, 32)
            } else {
                Button(action: {
                    if let message = viewModel.messages.dropLast().last?.custom {
                        FirebaseModule.logEvent(event: .event_MI1414, parameters: [
                            .contenu: message.tag ?? "",
                            .typeOptionsChatbot: "autres"
                        ])
                    }
                    showOtherQuestions = true
                    viewModel.refresh()
                }) {
                    Text("other_questions", bundle: .main)
                        .font(size: 14, weight: .regular, color: "Purple500")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Purple500", bundle: .main), lineWidth: 1)
                        )
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 16)
            }
        }
    }
}

