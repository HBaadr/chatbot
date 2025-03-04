//
//  File.swift
//  
//
//  Created by badr_hourimeche on 29/8/2024.
//

import SwiftUI

struct SatisfactionYes: View {
    @State private var commentValue: String = ""
    @ObservedObject var viewModel: SatisfactionBottomViewModel
    var onSoumettrePressed: () -> Void
    @Environment(\.locale) var locale

    var body: some View {
        VStack(alignment: .center) {
            
            Spacer()
            
            Image("icon_satisfaction", bundle: .main)
                .resizable()
                .frame(width: 100, height: 100)
            
            Spacer()
            
            Text("faites_nous_part_de_vos_commentaires", bundle: .main)
                .font(size: 20, weight: .bold, color: "Purple100")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            TextField("tapez_votre_motif".localizedString(locale: locale), text: $commentValue)
                .font(size: 14, color: "Black")
                .padding()
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(commentValue.isEmpty ? Color(hex: 0xFFc983b8) : Color("Inwi500", bundle: .main), lineWidth: 1)
                )
                .frame(maxWidth: .infinity)
                .padding(16)
            
            Button(action: {
                onSoumettrePressed()
                viewModel.setSatisfaction(satisfied: true, message: commentValue)
            }) {
                Text("soumettre", bundle: .main)
                    .font(size: 16, weight: .medium, color: "White")
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
            }
            .disabled(commentValue.isEmpty)
            .padding(8)
            .background(commentValue.isEmpty ? Color(hex: 0xFFc983b8) : Color("Inwi500", bundle: .main))
            .cornerRadius(8)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity)
    }
}
