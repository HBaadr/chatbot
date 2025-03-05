//
//  File.swift
//
//
//  Created by badr_hourimeche on 28/8/2024.
//

import SwiftUI


struct SatisfactionBottomSheet: View {
    var userInfos: UserInfos
    var onDismiss: () -> Void
    
    @State private var isYesPressed: Bool? = nil
    
    @ObservedObject private var viewModel: SatisfactionBottomViewModel
    
    init(userInfos: UserInfos, onDismiss: @escaping () -> Void) {
        FontsModule.registerFonts()
        self.userInfos = userInfos
        self.onDismiss = onDismiss
        let baseUrl = EnvironmentModule.getBaseUrl()
        self.viewModel = SatisfactionBottomViewModel(satisfactionUseCase: SatisfactionUseCase(baseUrl: baseUrl), userInfos: userInfos)
    }
    
    var body: some View {
        let view = VStack {
            Button(action: {
                withAnimation {
                    if isYesPressed == nil {
                        onDismiss()
                    }
                    isYesPressed = nil
                }
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color("Purple500", bundle: .main))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 32)
            
            switch isYesPressed {
            case true:
                SatisfactionYes(viewModel: viewModel) {
                    isYesPressed = nil
                    onDismiss()
                }
                
            case false:
                SatisfactionNo(viewModel: viewModel) {
                    isYesPressed = nil
                    onDismiss()
                }
                
            default:
                SatisfactionIdle(isYesPressed: $isYesPressed, viewModel: viewModel)
            }
        }
            .background(Color.white)
            .environment(\.locale, Locale(identifier: userInfos.lang.rawValue))
            .environment(\.layoutDirection,userInfos.lang == .arabe ? .rightToLeft : .leftToRight)
        
        if #available(iOS 16.4, *) {
            view
                .presentationDetents(
                    isYesPressed == true ? [.fraction(0.55)] :
                        isYesPressed == false ? [.fraction(0.8)] : [.fraction(0.5)] )
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
        } else if #available(iOS 16.0, *) {
            view
                .presentationDetents(
                    isYesPressed == true ? [.fraction(0.55)] :
                        isYesPressed == false ? [.fraction(0.8)] : [.fraction(0.5)] )
                .presentationDragIndicator(.visible)
        } else {
            view
        }
    }
}
