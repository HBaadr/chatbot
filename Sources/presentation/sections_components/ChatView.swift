//
//  ChatView.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI


struct ChatView: View {
    @ObservedObject var viewModel: ChatBotViewModel
    @Environment(\.locale) var locale
    let userInfos : UserInfos

    private var lastMessage: MessageItem? {
        viewModel.messages.last?.custom
    }
    
    private var previousMessageTag: String {
        guard viewModel.messages.count > 1 else { return "" }
        return viewModel.messages.dropLast().last?.custom?.tag ?? ""
    }
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 16) {
                            Spacer()
                                .frame(maxWidth: .infinity, minHeight: geo.size.height / CGFloat(viewModel.messages.count == 0 ? 1 : viewModel.messages.count))
                                .layoutPriority(-1)
                            
                            HStack(alignment: .center) {
                                Rectangle()
                                    .fill(Color("Gray400", bundle: .main))
                                    .frame(height: 1)
                                    .layoutPriority(1)
                                Text(formattedDate(locale: locale))
                                    .font(size: 12, weight: .medium, color: "Gray400")
                                    .padding(.horizontal, 8)
                                    .textCase(.uppercase)
                                    .layoutPriority(2)
                                Rectangle()
                                    .fill(Color("Gray400", bundle: .main))
                                    .frame(height: 1)
                                    .layoutPriority(1)
                            }
                            .padding(.horizontal, 16)
                            
                            ForEach(viewModel.messages, id: \.custom?.idd) { element in
                                switch element.custom?.type {
                                case .quickreply, .text:
                                    ChatItemBubble(userInfos: userInfos, message: element.custom!) {}
                                case .carousel_basic, .carousel_card, .carousel_banner, .carousel_package:
                                    ChatCarouselBubble(userInfos: userInfos, message: element.custom!, viewModel: viewModel)
                                case .home:
                                    VStack{}.frame(height: 0)
                                default:
                                    Text("")
                                }
                            }
                            
                            if viewModel.messagesGenesys.isEmpty && lastMessage?.enableSurvey == true {
                                SatisfactionSurveyView(viewModel: viewModel, userInfos: userInfos)
                            }
                            
                            if viewModel.messagesGenesys.isEmpty {
                                VStack {
                                    if viewModel.showLoadingBubble {
                                        InProgressChatItemBubble()
                                    }
                                    if lastMessage?.type == .quickreply {
                                        QuickReplyItems(options: lastMessage?.options ?? [], viewModel: viewModel)
                                            .padding(.horizontal, 12)
                                            .padding(.leading, 32)
                                            .frame(maxWidth: .infinity)
                                    } else if lastMessage?.survey_options?.isEmpty == false && viewModel.showOtherQuestions {
                                        OtherQuestions(viewModel : viewModel)
                                    }
                                }
                            } else {
                                
                                
                                let filteredMessages = viewModel.messagesGenesys.filter { $0.type == .message && $0.text?.contains("InteractionId") == false}
                                
                                ForEach(filteredMessages, id: \.idd) { element in
                                    ChatAgentBubble(userInfos: userInfos, message: element)
                                }
                                
                                if viewModel.showLoadingBubble {
                                    InProgressChatItemBubble()
                                }
                            }
                            
                            Color.clear.frame(height: 0)
                                .id("BOTTOM")
                        }
                        .frame(minHeight: geo.size.height)
                        .onChange(of: viewModel.refreshToggle) { _ in
                            withAnimation {
                                proxy.scrollTo("BOTTOM", anchor: .bottom)
                            }
                        }
                        .onChange(of: [viewModel.messages.count,viewModel.messagesGenesys.count]) { _ in
                            withAnimation {
                                proxy.scrollTo("BOTTOM", anchor: .bottom)
                            }
                        }
                    }
                }
            }
            
            if viewModel.messagesGenesys.isEmpty {
                
                ReturnToPreviousChoices {
                    viewModel.goBackToLastOperation()
                }
                .padding(.bottom, viewModel.showContactAgent && lastMessage?.enableSurvey == true ? 0 : 16)
                
                if viewModel.showContactAgent && lastMessage?.enableSurvey == true {
                    Button(action: {
                        if lastMessage?.isGenesysActivated == true {
                            let params: [FirebaseParam: String?] = [.contenu: "\(userInfos.lang.rawValue)_\(previousMessageTag ?? "")"]
                            FirebaseModule.logEvent(event: .event_MI1409, parameters: params)
                            viewModel.requestChat()
                            viewModel.refresh()
                        } else {
                            viewModel.addUnavailableAgentMessage(text: "agent_unavailable".localizedString(locale: locale))
                        }
                    }) {
                        Text("contacter_un_agent", bundle: .main)
                            .font(size: 16, weight: .medium, color: "Inwi500")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Inwi500", bundle: .main), lineWidth: 1)
                            )
                    }
                    .padding(.bottom, 16)
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
                }
            }
            
            if !viewModel.messagesGenesys.isEmpty && viewModel.showEditText {
                ChatTextField { message in
                    viewModel.sendChat(message: message)
                } onKeyboardVisible: {
                    viewModel.refresh()
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        viewModel.refresh()
                    }
                    viewModel.updateLocale(locale)
                }
            }
        }
    }
}

func formattedDate(locale : Locale) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE d MMMM yyyy"
    
    // Set the locale for the desired language
    formatter.locale = locale
    
    return formatter.string(from: Date()).uppercased()
}
