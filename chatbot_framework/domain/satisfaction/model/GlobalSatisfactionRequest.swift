//
//  GlobalSatisfactionRequest.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 28/8/2024.
//

import Foundation

struct GlobalSatisfactionRequest: Codable {
    var satisfied: Bool?
    var sessionId: String?
    var motif: String?
    var message: String?
    var id: Int?
}
