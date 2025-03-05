//
//  SatisfactionSurveyView.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI


struct SatisfactionSurveyView: View {
    @State private var isYesPressed: Bool = false
    @State private var isNoPressed: Bool = false
    @ObservedObject var viewModel: ChatBotViewModel
    let userInfos: UserInfos

    var body: some View {
        VStack {
            if isYesPressed {
                SatisfactionBarView(userInfos: userInfos, viewModel: viewModel)
            } else if !isNoPressed {
                SatisfactionIdleView(
                    userInfos: userInfos,
                    date: formatDateTime(dateTimeString: viewModel.messages.last?.custom?.messageDate),
                    onYesPressed: {
                            isYesPressed = true
                            isNoPressed = false
                            viewModel.showOtherQuestions = true
                            viewModel.refresh()
                            viewModel.sendUserSatisfaction(isUserSatisfied: true)
                    },
                    onNoPressed: {
                            isNoPressed = true
                            isYesPressed = false
                            viewModel.showOtherQuestions = true
                            viewModel.refresh()
                            viewModel.showAgent()
                            viewModel.sendUserSatisfaction(isUserSatisfied: false)
                    }
                )
                .onAppear {
                    viewModel.showOtherQuestions = false
                }
            }
        }.padding(.horizontal, 16)
    }
}
