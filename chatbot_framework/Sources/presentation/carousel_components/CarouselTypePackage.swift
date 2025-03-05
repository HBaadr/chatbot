//
//  CarouselTypePackage.swift
//  Chatbot
//
//  Created by badr_hourimeche on 8/10/2024.
//
import SwiftUI 

struct CarouselTypePackage: View {
    var message: OptionsItem
    @ObservedObject var viewModel: ChatBotViewModel
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center,spacing: 0) {
                    Text(message.price?.description ?? "")
                        .font(size: 41, weight: .bold, color: "Inwi700")
                    
                    Text("dh_mois", bundle: .main)
                        .font(size: 12, weight: .medium, color: "Inwi700")
                }
                Spacer()
                CarouselButton(message: message, viewModel: viewModel)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            Spacer().frame(height: 6)
            VStack(alignment: .leading, spacing: 0) {
                ForEach(message.details ?? [], id: \.title) { detail in
                    PackageItem(title: detail.title, image: detail.icon)
                }
            }
            .padding(.horizontal, 16)
            Spacer().frame(height: 6)
            Spacer()
        }
        .background(Color("Purple50", bundle: .main))
        .frame(maxWidth: screenWidth / 1.3, maxHeight: .infinity)
        .gradientBorder(
                    width: 6,
                    gradient: LinearGradient(
                        gradient: Gradient(colors: [Color("Inwi600", bundle: .main), Color(red: 216/255, green: 49/255, blue: 166/255)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    cornerRadius: 24
                )
    }
}


struct PackageItem: View {
    var title: String?
    var image: String?
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            ImageReader(url: image)
                    .frame(width: 24, height: 24)
                    .scaledToFill()
                    .padding(.trailing, 4)

            Text(title ?? "")
                .font(size: 14, weight: .regular, color: "Inwi700")
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(.top, 2)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}


struct GradientBorderModifier: ViewModifier {
    var width: CGFloat
    var gradient: LinearGradient
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(gradient, lineWidth: width)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}


extension View {
    func gradientBorder(width: CGFloat, gradient: LinearGradient, cornerRadius: CGFloat) -> some View {
        self.modifier(GradientBorderModifier(width: width, gradient: gradient, cornerRadius: cornerRadius))
    }
}
