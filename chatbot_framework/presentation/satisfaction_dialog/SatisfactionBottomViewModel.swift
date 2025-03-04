//
//  File.swift
//  
//
//  Created by badr_hourimeche on 28/8/2024.
//

import SwiftUI
import Combine


class SatisfactionBottomViewModel: ObservableObject {
    private var satisfactionUseCase: SatisfactionUseCase
    private var userInfos: UserInfos

    @Published var dissatisfactionReasons: [String] = []
    @Published var satisfactionId: Int? = nil
    private let TAG = "BADR_"

    private var cancellables = Set<AnyCancellable>()

    init(satisfactionUseCase: SatisfactionUseCase, userInfos: UserInfos) {
        self.satisfactionUseCase = satisfactionUseCase
        self.userInfos = userInfos
        getDissatisfactionReasons()
    }
    
    private func getDissatisfactionReasons() {
        Task {
            let response = await satisfactionUseCase.getDissatisfactionReasons(
                sdata: Encoder.encode(userInfo: userInfos) ?? ""
            )
            switch response {
            case .success(let response):
                await MainActor.run {
                    self.dissatisfactionReasons = response
                    print(TAG, "Data: \(response)")
                }
            case .failure(error: let error):
                await MainActor.run {
                    print(TAG, "Error: \(error!.localizedDescription)")
                }
            }
        }
    }
    
    func initSatisfaction(satisfied: Bool) {
        Task {
            let response = await satisfactionUseCase.globalSatisfaction(sdata: Encoder.encode(userInfo: userInfos) ?? "", satisfied: satisfied, sessionId: userInfos.mdn)
            switch response {
            case .success(let response):
                await MainActor.run {
                    print(TAG, "Data: \(response)")
                }
            case .failure(error: let error):
                await MainActor.run {
                    print(TAG, "Error: \(error!.localizedDescription)")
                }
            }
        }
    }
    
    func setSatisfaction(satisfied: Bool, message: String? = nil, motif: String? = nil) {
        Task {
            let response = await satisfactionUseCase.globalSatisfaction(
                sdata: Encoder.encode(userInfo: userInfos) ?? "",
                satisfied: satisfied,
                sessionId: userInfos.mdn,
                motif: motif,
                message: message
            )
            switch response {
            case .success(let response):
                await MainActor.run {
                    print(TAG, "Data: \(response)")
                }
            case .failure(error: let error):
                await MainActor.run {
                    print(TAG, "Error: \(error!.localizedDescription)")
                }
            }
        }
    }
}
