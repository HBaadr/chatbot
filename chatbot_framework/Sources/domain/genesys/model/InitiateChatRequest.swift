//
//  ChatRequest.swift
//  Chatbot
//
//  Created by badr_hourimeche on 20/9/2024.
//

import Foundation

struct InitiateChatRequest: Codable {
    var firstName: String?
    var lastName: String?
    var subject: String?
    var nickname: String?
}
