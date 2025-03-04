//
//  File.swift
//
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI


public struct ChatBotPackage {
    
    public static func chatBotView(
        userInfos: UserInfos,
        onHomeBackPressed: (() -> Void)? = nil
    ) -> some View {
        ChatBotView(
            userInfos: userInfos,
            onHomeBackPressed: onHomeBackPressed
        )
    }
    
    public static func satisfactionBottomSheet(
        userInfos: UserInfos,
        onDismiss: @escaping () -> Void
    ) -> some View {
        SatisfactionBottomSheet(
            userInfos: userInfos,
            onDismiss: onDismiss
        )
    }
    
    public static func setFirebaseCallback(
        _ callback: @escaping (FirebaseEvent, [String: Any]?) -> Void
    ) {
        FirebaseModule.setFirebaseCallback(callback)
    }
    
    public static func setRedirectCodeCallback(
        _ callback: @escaping (String) -> Void
    ) {
        RedirectCodeModule.setRedirectCodeCallback(callback)
    }
}
