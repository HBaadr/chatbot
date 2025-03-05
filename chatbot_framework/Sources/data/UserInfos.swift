//
//  UserInfos.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import Foundation

public struct UserInfos {
    let firstName: String
    let lastName: String
    let mdn: String
    let lang: Language
    let canal: String
    let profile: ProfileType

    
    public init(
        firstName: String,
        lastName: String,
        mdn: String,
        lang: Language = .francais,
        canal: String = "myinwi",
        profile: ProfileType = ProfileType.prepaid
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.mdn = mdn
        self.lang = lang
        self.canal = canal
        self.profile = profile
    }
}

public enum ProfileType: String, Codable {
    case prepaid
    case postpaid
    case wifi
}

public enum Language: String, Codable {
    case francais = "fr"
    case arabe = "ar"
}
