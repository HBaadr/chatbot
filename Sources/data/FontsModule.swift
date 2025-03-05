//
//  Fonts.swift
//  Chatbot
//
//  Created by badr_hourimeche on 23/9/2024.
//

import SwiftUI

internal enum BC : String, CaseIterable {
    case medium = "BasierCircle-Medium"
    case bold = "BasierCircle-Bold"
    case semibold = "BasierCircle-SemiBold"
    case regular = "BasierCircle-Regular"
}

private final class BundleToken {}

public struct FontsModule {
    
    static func registerFonts() {
        BC.allCases.forEach { font in
            registerFont(bundle: Bundle(for: BundleToken.self), fontName: font.rawValue, fontExtension: "otf")
        }
    }
    
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String){
      let pathForResourceString = bundle.path(forResource: fontName, ofType: fontExtension)
      let fontData = NSData(contentsOfFile: pathForResourceString!)
      let dataProvider = CGDataProvider(data: fontData!)
      let fontRef = CGFont(dataProvider!)
      var errorRef: Unmanaged<CFError>? = nil

      if (CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) == false) {
        NSLog("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
      }
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
