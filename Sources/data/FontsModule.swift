//
//  Fonts.swift
//  Chatbot
//
//  Created by badr_hourimeche on 23/9/2024.
//

import SwiftUI

internal enum BC : String, CaseIterable {
    case medium = "BasierCircle-Medium.otf"
    case bold = "BasierCircle-Bold.otf"
    case semibold = "BasierCircle-SemiBold.otf"
    case regular = "BasierCircle-Regular.otf"
}

public struct FontsModule {
    
    static func registerFonts() {
        BC.allCases.forEach { font in
            registerFont(bundle: .main, fontName: font.rawValue, fontExtension: "otf")
        }
    }
    
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String){
        
        // Check if the font is already registered
        if UIFont(name: fontName, size: 12) != nil {
            return
        }

        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }

        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)

    }
}

fileprivate extension Font {
    public static func bcFont(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        switch weight {
        case .medium:
            return .custom(BC.medium.rawValue, size: size)
            //return .system(size: size, weight: .medium, design: design)
        case .bold:
            return .custom(BC.bold.rawValue, size: size)
            //return .system(size: size, weight: .bold, design: design)
        case .semibold:
            return .custom(BC.semibold.rawValue, size: size)
            //return .system(size: size, weight: .semibold, design: design)
        default:
            return .custom(BC.regular.rawValue, size: size)
            //return .system(size: size, weight: .regular, design: design)
        }
    }
}

extension View {
    @ViewBuilder
    func font(
        size: CGFloat,
        weight: Font.Weight = .regular,
        color: String,
        spacing: CGFloat = 6
    ) -> some View {
        self
            .font(.bcFont(size: size, weight: weight))
            .lineSpacing(spacing)
            .foregroundColor(Color(color, bundle: .main))
    }
}
