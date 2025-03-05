//
//  File.swift
//  Chatbot
//
//  Created by badr_hourimeche on 20/9/2024.
//

import Foundation

protocol GenesysRepository {
    
    func initiateChat(requestBody: InitiateChatRequest) async -> Response<GenesysResponse>
    
    func sendChat(chatId: String, requestBody: SendChatRequest) async -> Response<GenesysResponse>

    func refreshChat(chatId: String, requestBody: SendChatRequest) async -> Response<GenesysResponse>
}
