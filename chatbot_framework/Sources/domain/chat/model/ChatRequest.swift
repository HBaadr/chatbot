//
//  ChatRequest.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import Foundation

struct ChatRequest: Codable {
    var sessionId: String?
    var message: String?
    var isChatStart: Bool
}
