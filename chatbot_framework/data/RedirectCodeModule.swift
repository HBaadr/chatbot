//
//  RedirectCode.swift
//  Chatbot
//
//  Created by badr_hourimeche on 23/9/2024.
//


import Foundation
import UIKit

public class RedirectCodeModule {

    private static var callback: ((String) -> Void)?

    static func setRedirectCodeCallback(_ callback: @escaping (String) -> Void) {
        self.callback = callback
    }

    static func logCode(code: String) {
        callback?(code)
    }
}


func redirect(message: OptionsItem, viewModel: ChatBotViewModel) {
    redirect(action: message.action, actionType: message.actionType, tag: message.tag) {
        viewModel.addUserText(option: message)
    }
}

func redirect(message: MessageItem) {
    redirect(action: message.action, actionType: message.actionType, tag: message.tag)
}

private func redirect(action: String?, actionType: OptionActionType?, tag: String?, onRasaOptionSelected: (() -> Void)? = nil) {
    let params: [FirebaseParam: String?] = [
        .contenu: tag ?? action,
        .typeOptionsChatbot: actionType?.rawValue
    ]
    FirebaseModule.logEvent(event: .event_MI1414, parameters: params)
    switch actionType {
    case .rasa:
        onRasaOptionSelected?()
        
    case .deeplink:
        if let action = action, let url = URL(string: action) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    case .internalAppLink:
        if let action = action {
            RedirectCodeModule.logCode(code: action)
        }
        
    case .none:
        // Nothing happens
        break
    }
}
