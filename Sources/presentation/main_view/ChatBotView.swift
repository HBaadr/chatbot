//
//  ChatBotView.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI



private final class BundleToken {}

struct ChatBotView: View {
    @StateObject private var viewModel: ChatBotViewModel
    @State private var openedSection: Int
    var userInfos: UserInfos
    var onHomeBackPressed: (() -> Void)?
    @State var openBottomSheet = false
    @State private var lastMessageType: CustomType?

    init(userInfos: UserInfos, onHomeBackPressed: (() -> Void)? = nil) {
        FontsModule.registerFonts()
        self.userInfos = userInfos
        self.openedSection = switch (userInfos.profile) {
        case .prepaid: 1
        case .postpaid: 2
        case .wifi: 3
        }
        let baseUrl = EnvironmentModule.getBaseUrl()
        self.onHomeBackPressed = onHomeBackPressed
        _viewModel = StateObject(wrappedValue: ChatBotViewModel(
            chatUseCase: ChatUseCase(baseUrl: baseUrl),
            satisfactionUseCase: SatisfactionUseCase(baseUrl: baseUrl),
            genesysUseCase: GenesysUseCase(baseUrl: baseUrl),
            userInfos: userInfos
        ))
        UserDefaults.standard.set(false, forKey: "typewriterTextDisplayedInSession")
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ChatHeader(
                showBackButton: onHomeBackPressed != nil && viewModel.messages.count <= 1,
                onBackPressed: {
                    FirebaseModule.logEvent(event: .event_MI1410)
                    if viewModel.messages.count > 1 {
                        openBottomSheet = true
                    } else {
                        onHomeBackPressed?()
                    }
                }
            )
            
            switch lastMessageType {
            case .home:
                ChatSections(
                    item: viewModel.messages.last!.custom!,
                    openedSection: $openedSection,
                    onSubSectionPressed: { viewModel.addUserText(option: $0) }
                )
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .transition(.opacity)

                case .carousel_basic, .carousel_card, .carousel_banner, .carousel_package, .quickreply, .text:
                ChatView(viewModel: viewModel, userInfos: userInfos)
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                        .transition(.opacity)

            default:
                VStack {}
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .transition(.opacity)

            }
        }
        .background(Color("Gray100", bundle: .main))
        .onChange(of: viewModel.messages.last?.custom?.type) { type in
            withAnimation {
                lastMessageType =  type
            }
        }
        .sheet(isPresented: $openBottomSheet) {
            CloseBottomSheet(onDismiss : {
                openBottomSheet = false
            }, onClosePressed: {
                viewModel.goBackToHome()
            })
            
        }
        .environment(\.locale, Locale(identifier: userInfos.lang.rawValue))
        .environment(\.layoutDirection,userInfos.lang == .arabe ? .rightToLeft : .leftToRight)
    }
}

