//
//  Encoder.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import Foundation

// Create an Encoder class with a static method for encoding
class Encoder {

    static func encode(userInfo: UserInfos) -> String? {
        let jsonString =
        "{\"firstname\":\"\(userInfo.firstName)\",\"lastname\":\"\(userInfo.lastName)\",\"mdn\":\"\(userInfo.mdn)\",\"lang\":\"\(userInfo.lang.rawValue)\",\"canal\":\"\(userInfo.canal)\",\"profile\":\"\(userInfo.profile.rawValue)\",\"os\":\"ios\"}"
        let data = jsonString.data(using: .utf8)!
        let base64String = data.base64EncodedString()
        return base64String
    }
    
    static func decode(_ string: String) -> String {
        if let decodedData = Data(base64Encoded: string) {
            return String(data: decodedData, encoding: .utf8) ?? ""
        }
        return ""
    }
}
