//
//  ChatTextField.swift
//  Chatbot
//
//  Created by badr_hourimeche on 20/9/2024.
//

import SwiftUI

struct ChatTextField: View {
    var sendMessage: (String) -> Void
    var onKeyboardVisible: () -> Void
    
    var body: some View {
        if #available(iOS 15.0, *) {
            NewChatTextField(sendMessage: sendMessage, onKeyboardVisible: onKeyboardVisible)
        } else {
            OldChatTextField(sendMessage: sendMessage, onKeyboardVisible: onKeyboardVisible)
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}

struct OldChatTextField: View, KeyboardReadable {
    @State private var commentValue: String = ""
    
    var sendMessage: (String) -> Void
    var onKeyboardVisible: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            TextField("", text: $commentValue, onCommit: {
                if !commentValue.isEmpty {
                    sendMessage(commentValue)
                    DispatchQueue.main.async {
                        commentValue = ""
                    }
                }
            })
            .onReceive(keyboardPublisher) { isKeyboardVisible in
                if isKeyboardVisible {
                    onKeyboardVisible()
                }
            }
            .font(size: 14, color: "Black")
            .padding(.vertical, 16)
            .padding(.leading, 16)
            .background(Color.clear)
            .placeholder(when: commentValue.isEmpty) {
                Text("tapez_votre_requ_te", bundle: .main)
                    .font(size: 14, weight: .regular, color: "GrayC2")
                    .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            
            
            Button(action: {
                if !commentValue.isEmpty {
                    sendMessage(commentValue)
                    commentValue = ""
                }
            }) {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(Color("White", bundle: .main))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(commentValue.isEmpty ? "Gray400" : "Inwi500", bundle: .main))
                    .clipShape(RoundedCorners(corners: .allCorners, radius: 30))
            }
            .padding(.trailing, 8)
            .padding(.vertical, 8)
        }
        .frame(height: 50)
        .background(Color("White", bundle: .main))
        .clipShape(RoundedCorners(corners: .allCorners, radius: 38))
        .overlay(
            RoundedRectangle(cornerRadius: 38)
                .stroke(Color("Gray200", bundle: .main), lineWidth: 0.5)
        )
        .shadow(color: Color("Gray400", bundle: .main), radius: 38, x: 0, y: 7)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

@available(iOS 15.0, *)
struct NewChatTextField: View, KeyboardReadable {
    @State private var commentValue: String = ""
    @FocusState var focused: Bool?
    
    var sendMessage: (String) -> Void
    var onKeyboardVisible: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            TextField("", text: $commentValue, onCommit: {
                onSubmit()
            })
            .onReceive(keyboardPublisher) { isKeyboardVisible in
                if isKeyboardVisible {
                    onKeyboardVisible()
                }
            }
            .focused($focused, equals: true)
            .submitLabel(.send)
            .font(size: 14, color: "Black")
            .padding(.vertical, 16)
            .padding(.leading, 16)
            .background(Color.clear)
            .placeholder(when: commentValue.isEmpty) {
                Text("tapez_votre_requ_te", bundle: .main)
                    .font(size: 14, weight: .regular, color: "GrayC2")
                    .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            
            Button(action: {
                if !commentValue.isEmpty {
                    onSubmit()
                } else {
                    DispatchQueue.main.async {
                        focused = true
                    }
                }
            }) {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(Color("White", bundle: .main))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(commentValue.isEmpty ? "Gray400" : "Inwi500", bundle: .main))
                    .clipShape(RoundedCorners(corners: .allCorners, radius: 30))
            }
            .padding(.trailing, 8)
            .padding(.vertical, 8)
        }
        .frame(height: 50)
        .background(Color("White", bundle: .main))
        .onTapGesture {
            DispatchQueue.main.async {
                focused = true
            }
        }
        .clipShape(RoundedCorners(corners: .allCorners, radius: 38))
        .overlay(
            RoundedRectangle(cornerRadius: 38)
                .stroke(Color("Gray200", bundle: .main), lineWidth: 0.5)
        )
        .shadow(color: Color("Gray400", bundle: .main), radius: 38, x: 0, y: 7)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    func onSubmit() {
        if !commentValue.isEmpty {
            sendMessage(commentValue)
            DispatchQueue.main.async {
                commentValue = ""
                focused = false
            }
        }
    }
}
