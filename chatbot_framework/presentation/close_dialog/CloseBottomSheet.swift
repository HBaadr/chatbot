//
//  CloseBottomSheet.swift
//  Chatbot
//
//  Created by badr_hourimeche on 18/9/2024.
//


import SwiftUI


struct CloseBottomSheet: View {
    var onDismiss: () -> Void
    var onClosePressed: () -> Void
    @Environment(\.locale) var locale

    init(onDismiss: @escaping () -> Void, onClosePressed: @escaping () -> Void) {
        self.onClosePressed = onClosePressed
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        let view = VStack {
            Button(action: {
                withAnimation {
                    onDismiss()
                }
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color("Purple500", bundle: .main))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 32)
            
            Spacer()
            Image("icon_question", bundle: .main)
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
            
            Text("pop_up_close_session_title", bundle: .main)
                .font(size: 20, weight: .bold, color: "Purple100")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            Text("pop_up_close_session_subtitle", bundle: .main)
                .font(size: 16, weight: .light, color: "Purple100")
                .multilineTextAlignment(.center)
                .padding(.top, 8)
                .padding(.horizontal, 16)

            HStack(spacing: 16) {
                Button(action: {
                    FirebaseModule.logEvent(event: .event_MI1413)
                    onDismiss()
                }) {
                    Text("non", bundle: .main)
                        .font(size: 16, weight: .regular, color: "Purple100")
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color("GrayEF", bundle: .main))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    FirebaseModule.logEvent(event: .event_MI1412)
                    onDismiss()
                    onClosePressed()
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
            .padding(.bottom, 16)        }
            .background(Color.white)
        
        if #available(iOS 16.4, *) {
            view
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
        } else if #available(iOS 16.0, *) {
            view
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
        } else {
            view
        }
    }
}
