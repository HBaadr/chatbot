//
//  ChatUseCase.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import Foundation


struct ChatUseCase{
    
    let chatRepository: ChatRepository
    
    init(baseUrl: String) {
        self.chatRepository = ChatRepositoryImpl(baseUrl: baseUrl)
    }
    
    func chat(
        sdata: String,
        message: String,
        sessionId: String,
        isChatStart: Bool
    ) async -> Response<ItemResponse> {
        
        let result = await chatRepository.chat(
            sdata: sdata,
            request: ChatRequest(
                sessionId: sessionId,
                message: message,
                isChatStart: isChatStart
            ))
            switch result {
            case .success(let response):
                return .success(data: response)
            case .failure(let error):
                return .failure(error: error)
            }
    }
}
