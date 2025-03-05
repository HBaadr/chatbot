//
//  File.swift
//  
//
//  Created by badr_hourimeche on 8/9/2024.
//

import Foundation

public class FirebaseModule {

    private static var callback: ((FirebaseEvent, [String: Any]? ) -> Void)?

    static func setFirebaseCallback(_ callback: @escaping (FirebaseEvent, [String: Any]?) -> Void) {
        self.callback = callback
    }

    static func logEvent(event: FirebaseEvent, parameters: [FirebaseParam: String?]? = nil) {
        let formattedParams = parameters != nil ? getParams(parameters!) : nil
        callback?(event, formattedParams)
    }
    
    static func getParams(_ params: [FirebaseParam: String?]) -> [String: String] {
        return params.reduce(into: [String: String]()) { result, pair in
            result[pair.key.rawValue] = pair.value ?? ""
        }
    }
}

public enum FirebaseParam: String {
    case typeOptionsChatbot = "type_options_chatbot"
    case contenu = "contenu"
}

public enum FirebaseEvent: String {
    case event_MI1401 = "MI1401_init_chatbot_home"
    case event_MI1402 = "MI1402_init_chatbot_support"
    case event_MI1403 = "MI1403_init_cat_prp"
    case event_MI1404 = "MI1404_init_cat_psp"
    case event_MI1405 = "MI1405_init_cat_home"
    case event_MI1406 = "MI1406_init_chat_prp"
    case event_MI1407 = "MI1407_init_chat_psp"
    case event_MI1408 = "MI1408_init_chat_home"
    case event_MI1409 = "MI1409_contacter_agent"
    case event_MI1410 = "MI1410_retour_accueil_header"
    case event_MI1411 = "MI1411_retour_accueil_footer"
    case event_MI1412 = "MI1412_popup_reply_yes"
    case event_MI1413 = "MI1413_popup_reply_non"
    case event_MI1414 = "MI1414_init_options"
}
