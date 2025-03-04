//
//  Response.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import Foundation

enum Response<T> {
    case success(data: T)
    case failure(error: Error?)
}

