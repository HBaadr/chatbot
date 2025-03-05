//
//  EnvironmentModule.swift
//  Chatbot
//
//  Created by badr_hourimeche on 25/9/2024.
//
import Foundation

enum EnvironmentModule: String, CaseIterable {
    case dev = "https://api-gtw-dev-new.inwi.ma/api/ms-chat/v1/"
    case recette = "https://api-gtw-rct-new.inwi.ma/api/ms-chat/v1/"
    case preprod = "https://api-gtw-pprd-new.inwi.ma/api/ms-chat/v1/"
    case prod = "https://api.inwi.ma/api/ms-chat/v1/"

    private var packageNames: [String] {
        switch self {
        case .dev:
            return ["ma.inwi.selfcaremobile.dev"]
        case .recette:
            return ["ma.inwi.selfcaremobile.recette"]
        case .preprod:
            return ["ma.inwi.selfcaremobile.preprod"]
        case .prod:
            return ["ma.inwi.selfcaremobile", "ma.inwi.ChatbotApp"]
        }
    }

    static func getBaseUrl() -> String {
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? ""
        for env in EnvironmentModule.allCases {
            if env.packageNames.contains(bundleIdentifier) {
                return env.rawValue
            }
        }
        return EnvironmentModule.dev.rawValue
    }
}
