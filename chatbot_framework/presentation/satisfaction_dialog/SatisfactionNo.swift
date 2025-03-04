//
//  File.swift
//  
//
//  Created by badr_hourimeche on 29/8/2024.
//

import SwiftUI

struct SatisfactionNo: View {
    @State private var selectedOption: String = ""
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
            
            Text("motif_d_insatisfaction", bundle: .main)
                .font(size: 20, weight: .bold, color: "Purple100")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)

            ForEach(viewModel.dissatisfactionReasons, id: \.self) { text in
                RadioButton(text: text, isSelected: text == selectedOption) {
                    selectedOption = text
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            
            if selectedOption.lowercased() == "autre".localizedString(locale: locale) {
                TextField("tapez_votre_motif".localizedString(locale: locale), text: $commentValue)
                    .font(size: 14, color: "Black")
                    .padding()
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(commentValue.isEmpty ? Color(hex: 0xFFc983b8) : Color("Inwi500", bundle: .main), lineWidth: 1)
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
            }
            
            Button(action: {
                onSoumettrePressed()
                viewModel.setSatisfaction(satisfied: false, message: commentValue, motif: selectedOption)
            }) {
                Text("soumettre", bundle: .main)
                    .font(size: 16, weight: .medium, color: "White")
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
            }
            .disabled(selectedOption.isEmpty)
            .padding(8)
            .background(selectedOption.isEmpty ? Color(hex: 0xFFc983b8) : Color("Inwi500", bundle: .main))
            .cornerRadius(8)
            .padding(16)
        }
        .frame(maxWidth: .infinity)
    }
}

struct RadioButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        
        HStack(spacing: 0) {
            if isSelected {
                Image(systemName: "record.circle") // circle.inset.filled
                    .foregroundColor(Color("Inwi500", bundle: .main))
                    .frame(width: 20, height: 20)
            } else {
                Image(systemName: "circle")
                    .foregroundColor(Color("Gray200", bundle: .main))
                    .frame(width: 20, height: 20)
            }
            
            Text(text)
                .font(size: 14, weight: .medium, color: "Black")
                .padding(.leading, 8)
        }.onTapGesture {
            action()
        }
    }
}
