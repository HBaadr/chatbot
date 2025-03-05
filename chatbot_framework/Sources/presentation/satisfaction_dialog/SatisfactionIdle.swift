//
//  File.swift
//  
//
//  Created by badr_hourimeche on 28/8/2024.
//

import SwiftUI


struct SatisfactionIdle: View {
    @Binding var isYesPressed: Bool?
    var viewModel: SatisfactionBottomViewModel
    
    var body: some View {
        VStack {
            
            Spacer()
            Image("icon_satisfaction", bundle: .main)
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
            
            Text("tes_vous_satisfait_de_votre_exp_rience_avec_le_chatbot", bundle: .main)
                .font(size: 20, weight: .bold, color: "Purple100")
            
            HStack(spacing: 16) {
                Button(action: {
                    isYesPressed = false
                    viewModel.initSatisfaction(satisfied: false)
                }) {
                    Text("non", bundle: .main)
                        .font(size: 16, weight: .regular, color: "Purple100")
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color("GrayEF", bundle: .main))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    isYesPressed = true
                    viewModel.initSatisfaction(satisfied: true)
                }) {
                    Text("oui", bundle: .main)
                        .font(size: 16, weight: .regular, color: "White")
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color("Inwi500", bundle: .main))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
    }
}
