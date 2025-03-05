//
//  ChatRepository.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import Foundation

protocol ChatRepository {
    func chat(sdata: String, request: ChatRequest) async -> Response<ItemResponse>
}
