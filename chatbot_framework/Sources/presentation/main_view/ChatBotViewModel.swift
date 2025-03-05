//
//  ChatBotViewModel.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import Foundation
import Combine


class ChatBotViewModel: ObservableObject {
    @Published var messages: [ItemResponse] = []
    @Published var messagesGenesys: [MessagesItem] = []
    @Published var genesysResponse: GenesysResponse? = nil
    @Published var refreshToggle: Bool = false
    @Published var showContactAgent: Bool = false
    @Published var showOtherQuestions: Bool = true
    @Published var loopStarted: Bool = false
    @Published var showEditText: Bool = true
    @Published var showLoadingBubble: Bool = false
    @Published var locale: Locale = .current

    private let TAG = "BADR_"
    private let chatUseCase: ChatUseCase
    private let satisfactionUseCase: SatisfactionUseCase
    private let genesysUseCase: GenesysUseCase
    private let userInfos: UserInfos
    
    private var cancellables = Set<AnyCancellable>()
    
    init(chatUseCase: ChatUseCase, satisfactionUseCase: SatisfactionUseCase, genesysUseCase: GenesysUseCase, userInfos: UserInfos) {
        self.chatUseCase = chatUseCase
        self.satisfactionUseCase = satisfactionUseCase
        self.genesysUseCase = genesysUseCase
        self.userInfos = userInfos
        
        getData(action: "main_menu", isChatStart: true)
    }
    
    func updateLocale(_ newLocale: Locale) {
        locale = newLocale
    }
    
    func addUnavailableAgentMessage(text : String) {
        let message = ItemResponse(
            custom: MessageItem(
                text: text,
                type: .text,
                isUser: false
            )
        )
        messages.append(message)
    }
    
    func getData(action: String, isChatStart: Bool = false) {
        showContactAgent = false
        showLoadingBubble = true
        Task {
            let response = await chatUseCase.chat(
                sdata: Encoder.encode(userInfo: userInfos) ?? "",
                message: action,
                sessionId: userInfos.mdn,
                isChatStart: isChatStart
            )
            switch response {
            case .success(let response):
                await MainActor.run {
                    self.messages.append(response)
                    showLoadingBubble = false
                    print(TAG, "Data: \(response) + \(messages.count)")
    }
            case .failure(error: let error):
                await MainActor.run {
                    print(TAG, "Error: \(error!.localizedDescription)")
                    showLoadingBubble = false
                }
            }
        }

    }
    
    func showAgent(){
        self.showContactAgent = true
    }
    
    func addUserText(option: OptionsItem) {
        let message = ItemResponse(
            custom: MessageItem(
                text: option.title,
                messageDate: Date().description.localizedLowercase, 
                type: .text,
                isUser: true,
                correspondingAction: option.action,
                tag: option.tag
            )
        )
        messages.append(message)
        print(TAG, "User: \(message.custom?.text ?? "") + \(messages.count)")
        if let action = option.action {
            getData(action: action)
        }
    }
    
    func goBackToLastOperation() {
        showContactAgent = false
        // Filtering messages to find user messages
        let userMessages = messages.filter { $0.custom?.isUser == true }
        
        // Try to perform operations
        do {
            // Ensure there are messages to process
            guard let lastMessage = userMessages.last else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No messages available"])
            }
            
            // Find the first message with the same action as the last message
            guard let firstLastMessage = userMessages.first(where: { $0.custom?.correspondingAction == lastMessage.custom?.correspondingAction }) else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Corresponding action not found"])
            }
            
            // Find the index of the target message
            guard let indexOfTarget = userMessages.firstIndex(of: firstLastMessage), indexOfTarget > 0 else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Target index out of bounds"])
            }
            
            // Retrieve the target message
            let target = userMessages[indexOfTarget - 1]
            
            // Create the options item
            let optionsItem = OptionsItem(
                action: target.custom?.correspondingAction,
                title: target.custom?.text,
                tag: target.custom?.tag
            )
            
            // Call the function to handle the options item
            addUserText(option: optionsItem)
            
        } catch {
            // Handle error by going back to home
            FirebaseModule.logEvent(event: .event_MI1411)
            goBackToHome()
        }
    }

    
    func goBackToHome() {
        messages.removeAll()
        messagesGenesys.removeAll()
        genesysResponse = nil
        getData(action: "main_menu")
    }
    
    func refresh() {
        refreshToggle.toggle()
    }
    
    func sendUserSatisfaction(isUserSatisfied: Bool = true, rating: Int = 0) {
        Task {
            let requestId = messages.last?.satisfactionId ?? 0
            let response = await satisfactionUseCase.traversalSatisfaction(
                sdata: Encoder.encode(userInfo: userInfos) ?? "",
                id: requestId,
                rating: rating,
                satisfied: isUserSatisfied
            )
            switch response {
            case .success(let response):
                await MainActor.run {
                    print(TAG, "Data: \(response)")
                }
            case .failure(error: let error):
                await MainActor.run {
                    print(TAG, "Error: \(error!.localizedDescription)")
                }
            }
        }
    }
    
    func requestChat() {
        showLoadingBubble = true
        Task {
            let response = await genesysUseCase.initiateChat(
                firstName: userInfos.firstName,
                lastName: userInfos.lastName,
                subject: userInfos.profile.rawValue
            )
            switch response {
            case .success(let response):
                await MainActor.run {
                    self.genesysResponse = response
                    updateMessages(messages: response.messages)
                    showLoadingBubble = false
                    print(TAG, "Data: \(response)")
                }
            case .failure(error: let error):
                await MainActor.run {
                    print(TAG, "Error: \(error!.localizedDescription)")
                    showLoadingBubble = false
                }
            }
        }
    }
    
    func sendChat(message: String) {
        
        let msg = MessagesItem(
            from : From(
                nickname : "\(userInfos.firstName) \(userInfos.lastName)",
                type : .client
            ),
            text : message,
            type : .message
        )
        messagesGenesys.append(msg)
        
        guard let response = genesysResponse else { return }
        guard let chatId = response.chatId else { return }

        Task {
            let result = await genesysUseCase.sendChat(
                chatId: chatId,
                secureKey: response.secureKey ?? "",
                alias: response.alias ?? "",
                message: message ?? "",
                userId: response.userId ?? ""
            )

            await MainActor.run {
                switch result {
                case .success(let response):
                    updateMessages(messages: response.messages)
                    if !loopStarted {
                        startTheLoop()
                    }
                    print(TAG, "Data2: \(response)")
                case .failure(let error):
                    print(TAG, "Error: \(error!.localizedDescription)")
                }
            }
        }
    }
    
    func refreshChat() {
        guard let response = genesysResponse else { return }
        guard let chatId = response.chatId else { return }
        
        Task {
            let result = await genesysUseCase.refreshChat(
                chatId: chatId,
                secureKey: response.secureKey ?? "",
                alias: response.alias ?? "",
                userId: response.userId ?? ""
            )

            await MainActor.run {
                switch result {
                case .success(let response):
                    updateMessages(messages: response.messages)
                    print(TAG, "Data3: \(response)")
                case .failure(let error):
                    print(TAG, "Error: \(error!.localizedDescription)")
                }
            }
        }
    }

    
    private func startTheLoop() {
        Task {
            await MainActor.run {
                loopStarted = true
            }
            let maxRange = genesysResponse?.config?.refreshMaxNumber ?? 100
            let refreshFrequency = genesysResponse?.config?.refreshFrequency ?? 1
            for _ in 0..<maxRange {
                if !loopStarted {
                    break
                }
                refreshChat()
                try await Task.sleep(nanoseconds: 1_000_000_000 * UInt64(refreshFrequency))
            }
            await MainActor.run {
                loopStarted = false
            }
        }
    }
    
    private func updateMessages(messages: [MessagesItem]?) {
        if genesysResponse != nil {
            if messages?.count ?? 0 >= messagesGenesys.count {
                messagesGenesys.removeAll()
                messagesGenesys.append(contentsOf: messages!)
                refresh()
            } else {
                closeGenesys()
            }
        }
    }
    
    private func closeGenesys(){
        showEditText = false
        loopStarted = false
        let message = MessagesItem(
            from : From(
                nickname : "bot".localizedString(locale: locale),
                type : .agent
            ),
            text : "end_genesys".localizedString(locale: locale),
            type : .message
        )
        messagesGenesys.append(message)
    }
}
