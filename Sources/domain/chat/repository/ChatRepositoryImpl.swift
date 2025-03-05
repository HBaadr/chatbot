//
//  ChatRepositoryImpl.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import Foundation


class ChatRepositoryImpl : ChatRepository {
    
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func chat(sdata: String, request: ChatRequest) async -> Response<ItemResponse> {
        // Define your endpoint URL
        let urlString = "\(baseUrl)chat"

        // Create URL from the endpoint URL string
        guard let url = URL(string: urlString) else {
            return .failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }
        
        
        // Prepare the request body as a dictionary
        let requestBody: [String: Any] = [
            "sessionId": request.sessionId ?? "",
            "message": request.message ?? "",
            "isChatStart": request.isChatStart,
        ]
        
        // Convert the request body to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            return .failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize request body"]))
        }
        
        // Create a URLRequest with POST method and set the request body
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(sdata, forHTTPHeaderField: "sdata")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        do {
            // Perform the network request asynchronously
            let (data, _) = try await URLSession.shared.data(for: request)

            // Decode JSON data into TimezoneResponse model
            let decoder = JSONDecoder()
            let response = try decoder.decode(ItemResponse.self, from: data)

            return .success(data: response)
        } catch {
            print("BADR_G \(error)")
            return .failure(error: error)
        }
    }
}
