//
//  ChatRepositoryImpl.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import Foundation


class GenesysRepositoryImpl : GenesysRepository {
    
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func initiateChat(requestBody: InitiateChatRequest) async -> Response<GenesysResponse> {

        let urlString = "\(baseUrl)genesys/chat"

        guard let url = URL(string: urlString) else {
            return .failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }
        
        
        // Prepare the request body as a dictionary
        let requestBody: [String: Any] = [
            "firstName" : requestBody.firstName,
            "lastName" : requestBody.lastName,
            "subject" : requestBody.subject,
            "nickname" : requestBody.firstName ?? "" + (requestBody.lastName ?? "")
        ]
        
        // Convert the request body to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            return .failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize request body"]))
        }
        
        // Create a URLRequest with POST method and set the request body
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        do {
            // Perform the network request asynchronously
            let (data, _) = try await URLSession.shared.data(for: request)

            // Decode JSON data into TimezoneResponse model
            let decoder = JSONDecoder()
            let response = try decoder.decode(GenesysResponse.self, from: data)

            return .success(data: response)
        } catch {
            print("BADR_G \(error)")
            return .failure(error: error)
        }
    }
    
    func sendChat(chatId: String, requestBody: SendChatRequest) async -> Response<GenesysResponse> {
        let urlString = "\(baseUrl)genesys/chat/\(chatId)/send"

        guard let url = URL(string: urlString) else {
            return .failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }
        
        
        // Prepare the request body as a dictionary
        let requestBody: [String: Any] = [
            "secureKey" : requestBody.secureKey,
            "alias" : requestBody.alias,
            "message" : requestBody.message,
            "userId" : requestBody.userId
        ]
        
        // Convert the request body to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            return .failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize request body"]))
        }
        
        // Create a URLRequest with POST method and set the request body
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        do {
            // Perform the network request asynchronously
            let (data, _) = try await URLSession.shared.data(for: request)

            // Decode JSON data into TimezoneResponse model
            let decoder = JSONDecoder()
            let response = try decoder.decode(GenesysResponse.self, from: data)

            return .success(data: response)
        } catch {
            print("BADR_G \(error)")
            return .failure(error: error)
        }
    }
    
    func refreshChat(chatId: String, requestBody: SendChatRequest) async -> Response<GenesysResponse> {
        let urlString = "\(baseUrl)genesys/chat/\(chatId)/refresh"

        guard let url = URL(string: urlString) else {
            return .failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }
        
        
        // Prepare the request body as a dictionary
        let requestBody: [String: Any] = [
            "secureKey" : requestBody.secureKey,
            "alias" : requestBody.alias,
            "message" : requestBody.message,
            "userId" : requestBody.userId
        ]
        
        // Convert the request body to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            return .failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize request body"]))
        }
        
        // Create a URLRequest with POST method and set the request body
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        do {
            // Perform the network request asynchronously
            let (data, _) = try await URLSession.shared.data(for: request)

            // Decode JSON data into TimezoneResponse model
            let decoder = JSONDecoder()
            let response = try decoder.decode(GenesysResponse.self, from: data)

            return .success(data: response)
        } catch {
            print("BADR_G \(error)")
            return .failure(error: error)
        }
    }
    
}
