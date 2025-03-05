//
//  GenesysResponse.kt.swift
//  Chatbot
//
//  Created by badr_hourimeche on 20/9/2024.
//

import Foundation

struct GenesysResponse: Codable {
    var secureKey: String?
    var chatId: String?
    var nextPosition: Int?
    var messages: [MessagesItem]?
    var alias: String?
    var chatEnded: Bool?
    var userId: String?
    var statusCode: Int?
    var monitored: Bool?
    var config: Config?
}

struct MessagesItem: Codable {
    var utcTime: Int64?
    var index: Int?
    var from: From?
    var text: String?
    var type: MessageType?
    
    var idd : String {
        return "\(utcTime?.description ?? "") + \(index ?? 0) + \(text ?? "") + \(type?.rawValue ?? "") + \(from?.participantId?.description ?? "") + \(from?.nickname ?? "") + \(from?.type?.rawValue ?? "")"
    }
}

struct From: Codable {
    var participantId: Int?
    var nickname: String?
    var type: UserType?
}

struct Config: Codable {
    var refreshMaxNumber: Int?
    var refreshFrequency: Int?
}

enum UserType: String, Codable {
    case client = "Client"
    case external = "External"
    case system = "System"
    case agent = "Agent"
}

enum MessageType: String, Codable {
    case message = "Message"
    case participantJoined = "ParticipantJoined"
    case typingStarted = "TypingStarted"
}
