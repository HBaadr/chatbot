//
//  File.swift
//  Chatbot
//
//  Created by badr_hourimeche on 20/9/2024.
//

import Foundation

struct SendChatRequest: Codable {
    var secureKey: String?
    var alias: String?
    var message: String?
    var userId: String?
}
