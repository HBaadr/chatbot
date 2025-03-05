//
//  SatisfactionRepositoryImpl.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 28/8/2024.
//

import Foundation


class SatisfactionRepositoryImpl : SatisfactionRepository {
    
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func traversalSatisfaction(sdata: String, request: TraversalSatisfactionRequest) async -> Response<TraversalSatisfactionResponse> {
        // Define your endpoint URL
        let urlString = "\(baseUrl)traversal-satisfaction"

        // Create URL from the endpoint URL string
        guard let url = URL(string: urlString) else {
            return .failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }
        
        
        // Prepare the request body as a dictionary
        let requestBody: [String: Any?] = [
            "satisfied": request.satisfied,
            "rating": request.rating,
            "id": request.id,
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
            let response = try decoder.decode(TraversalSatisfactionResponse.self, from: data)

            return .success(data: response)
        } catch {
            print("BADR_G \(error)")
            return .failure(error: error)
        }
    }
    
    func getDissatisfactionReasons(sdata: String) async -> Response<[String]> {
        let urlString = "\(baseUrl)dissatisfaction-reason"

        // Create URL from the endpoint URL string
        guard let url = URL(string: urlString) else {
            return .failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }
        
        // Create a URLRequest with POST method and set the request body
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(sdata, forHTTPHeaderField: "sdata")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Perform the network request asynchronously
            let (data, _) = try await URLSession.shared.data(for: request)

            // Decode JSON data into TimezoneResponse model
            let decoder = JSONDecoder()
            let response = try decoder.decode([String].self, from: data)

            return .success(data: response)
        } catch {
            print("BADR_G \(error)")
            return .failure(error: error)
        }
    }
    
    func globalSatisfaction(sdata: String, request: GlobalSatisfactionRequest) async -> Response<TraversalSatisfactionResponse> {
        let urlString = "\(baseUrl)satisfaction"

        // Create URL from the endpoint URL string
        guard let url = URL(string: urlString) else {
            return .failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }
        
        // Prepare the request body as a dictionary
        let requestBody: [String: Any?] = [
            "satisfied": request.satisfied,
            "sessionId": request.sessionId,
            "motif": request.motif,
            "message": request.message,
            "id": request.id,
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
            let response = try decoder.decode(TraversalSatisfactionResponse.self, from: data)

            return .success(data: response)
        } catch {
            print("BADR_G \(error)")
            return .failure(error: error)
        }
    }
}
