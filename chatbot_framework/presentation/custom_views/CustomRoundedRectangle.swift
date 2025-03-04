//
//  Untitled.swift
//  Chatbot
//
//  Created by badr_hourimeche on 5/10/2024.
//
import SwiftUI

struct CustomRoundedRectangle: Shape {
    var topLeadingRadius: CGFloat = 12
    var bottomLeadingRadius: CGFloat = 12
    var bottomTrailingRadius: CGFloat = 12
    var topTrailingRadius: CGFloat = 12
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: 0, y: topLeadingRadius))
        path.addArc(center: CGPoint(x: topLeadingRadius, y: topLeadingRadius), radius: topLeadingRadius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        
        path.addLine(to: CGPoint(x: width - topTrailingRadius, y: 0))
        path.addArc(center: CGPoint(x: width - topTrailingRadius, y: topTrailingRadius), radius: topTrailingRadius, startAngle: .degrees(270), endAngle: .degrees(360), clockwise: false)
        
        path.addLine(to: CGPoint(x: width, y: height - bottomTrailingRadius))
        
        path.addArc(center: CGPoint(x: width - bottomTrailingRadius, y: height - bottomTrailingRadius), radius: bottomTrailingRadius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        
        path.addLine(to: CGPoint(x: bottomLeadingRadius, y: height))
        
        path.addArc(center: CGPoint(x: bottomLeadingRadius, y: height - bottomLeadingRadius), radius: bottomLeadingRadius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        
        path.addLine(to: CGPoint(x: 0, y: topLeadingRadius))
        
        return path
    }
}


struct RoundedCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCornerWithBorder(lineWidth: CGFloat, borderColor: Color, radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
            .overlay(RoundedCorner(radius: radius, corners: corners)
                .stroke(borderColor, lineWidth: lineWidth))
    }
}
