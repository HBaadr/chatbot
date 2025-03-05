//
//  ChatResponse.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import Foundation

struct ItemResponse: Codable, Equatable {
    var custom: MessageItem?
    var sessionId: String?
    var satisfactionId: Int?
    
    static func ==(lhs: ItemResponse, rhs: ItemResponse) -> Bool {
        return lhs.custom == rhs.custom && lhs.sessionId == rhs.sessionId && lhs.satisfactionId == rhs.satisfactionId
    }
}

struct MessageItem: Codable, Equatable {
    var buttonText: String?
    var actionType: OptionActionType?
    var action: String?
    var enableSurvey: Bool? = false
    var options: [OptionsItem]?
    var survey_options: [OptionsItem]?
    var text: String?
    var messageDate: String?
    var type: CustomType?
    var isLastStep: Bool? = false
    var isGenesysActivated: Bool? = false
    var isUser: Bool? = false
    var correspondingAction: String?
    var tag: String?
    
    var idd : String {
        return "\(buttonText ?? "") + \(action ?? "") + \(text ?? "") + \(messageDate ?? "") + \(correspondingAction ?? "") + \(action?.description ?? "")"
    }
    
    static func == (lhs: MessageItem, rhs: MessageItem) -> Bool {
        return  lhs.action == rhs.action &&
                lhs.text == rhs.text &&
                lhs.buttonText == rhs.buttonText &&
                lhs.messageDate == rhs.messageDate &&
                lhs.isLastStep == rhs.isLastStep &&
                lhs.isUser == rhs.isUser &&
                lhs.correspondingAction == rhs.correspondingAction &&
                lhs.tag == rhs.tag
    }
}

struct OptionsItem: Codable {
    var buttonText: String?
    var actionType: OptionActionType?
    var action: String?
    var title: String?
    var category: OptionCategory?
    var image: String?
    var packageStar: String?
    var tag: String?
    var price: Int?
    var details: [OptionDetail]?
    var idd : String {
        return "\(title ?? "") + \(price ?? 0) + \(action ?? "") + \(buttonText ?? "") + \(image ?? "") + \(packageStar ?? "")"
    }
}

struct OptionDetail: Codable {
    var icon: String?
    var title: String?
}

enum CustomType: String, Codable {
    case home
    case text
    case quickreply
    case carousel_basic
    case carousel_card
    case carousel_banner
    case carousel_package
}

enum OptionCategory: String, Codable {
    case prepaid
    case postpaid
    case wifi
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self = OptionCategory(rawValue: value) ?? .unknown
    }
}

enum OptionActionType: String, Codable {
    case rasa
    case deeplink
    case internalAppLink
}
