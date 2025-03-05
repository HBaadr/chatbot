//
//  SatisfactionUseCase.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 28/8/2024.
//

import Foundation


struct SatisfactionUseCase{
    
    let satisfactionRepository: SatisfactionRepository
    
    init(baseUrl: String) {
        self.satisfactionRepository = SatisfactionRepositoryImpl(baseUrl: baseUrl)
    }
    
    func traversalSatisfaction(
        sdata: String,
        id: Int,
        rating: Int,
        satisfied: Bool
    ) async -> Response<TraversalSatisfactionResponse> {
        
        let result = await satisfactionRepository.traversalSatisfaction(
            sdata: sdata,
            request: TraversalSatisfactionRequest(
                satisfied: satisfied,
                rating: rating,
                id: id
            ))
        switch result {
        case .success(let response):
            return .success(data: response)
        case .failure(let error):
            return .failure(error: error)
        }
    }
    
    func getDissatisfactionReasons(
        sdata: String
    ) async -> Response<[String]> {
        
        let result = await satisfactionRepository.getDissatisfactionReasons(
            sdata: sdata
        )
        switch result {
        case .success(let response):
            return .success(data: response)
        case .failure(let error):
            return .failure(error: error)
        }
    }
    
    func globalSatisfaction(
        sdata: String,
        satisfied: Bool,
        sessionId: String,
        id: Int? = nil,
        motif: String? = nil,
        message: String? = nil
    ) async -> Response<TraversalSatisfactionResponse> {
        
        let result = await satisfactionRepository.globalSatisfaction(
            sdata: sdata,
            request: GlobalSatisfactionRequest(
                satisfied: satisfied,
                sessionId: sessionId,
                motif: motif,
                message: message,
                id: id
            ))
        switch result {
        case .success(let response):
            return .success(data: response)
        case .failure(let error):
            return .failure(error: error)
        }
    }
}
