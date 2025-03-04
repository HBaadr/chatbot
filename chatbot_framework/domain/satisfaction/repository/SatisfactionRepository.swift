//
//  SatisfactionRepository.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 28/8/2024.
//

import Foundation

protocol SatisfactionRepository {
    
    func traversalSatisfaction(sdata: String, request: TraversalSatisfactionRequest) async -> Response<TraversalSatisfactionResponse>
    
    func getDissatisfactionReasons(sdata: String) async -> Response<[String]>
    
    func globalSatisfaction(sdata: String, request: GlobalSatisfactionRequest) async -> Response<TraversalSatisfactionResponse>
    
}
