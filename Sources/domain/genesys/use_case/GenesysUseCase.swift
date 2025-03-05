//
//  GenesysUseCase.swift
//  Chatbot
//
//  Created by badr_hourimeche on 20/9/2024.
//

import Foundation


struct GenesysUseCase{
    
    let genesysRepository: GenesysRepository
    
    init(baseUrl: String) {
        self.genesysRepository = GenesysRepositoryImpl(baseUrl: baseUrl)
    }
    
    func initiateChat(
        firstName: String,
        lastName: String,
        subject: String,
        nickname: String? = nil
    ) async -> Response<GenesysResponse> {
        
        let result = await genesysRepository.initiateChat(
            requestBody: InitiateChatRequest(
                firstName: firstName,
                lastName: lastName,
                subject: subject,
                nickname: nickname
            ))
            switch result {
            case .success(let response):
                return .success(data: response)
            case .failure(let error):
                return .failure(error: error)
            }
    }
    
    func sendChat(
        chatId: String,
        secureKey: String,
        alias: String,
        message: String,
        userId: String
    ) async -> Response<GenesysResponse> {
        
        let result = await genesysRepository.sendChat(
            chatId: chatId,
            requestBody: SendChatRequest(
                secureKey: secureKey,
                alias: alias,
                message: message,
                userId: userId
            ))
            switch result {
            case .success(let response):
                return .success(data: response)
            case .failure(let error):
                return .failure(error: error)
            }
    }
    
    func refreshChat(
        chatId: String,
        secureKey: String,
        alias: String,
        message: String? = nil,
        userId: String
    ) async -> Response<GenesysResponse> {
        
        let result = await genesysRepository.refreshChat(
            chatId: chatId,
            requestBody: SendChatRequest(
                secureKey: secureKey,
                alias: alias,
                message: message,
                userId: userId
            ))
            switch result {
            case .success(let response):
                return .success(data: response)
            case .failure(let error):
                return .failure(error: error)
            }
    }
    
}
