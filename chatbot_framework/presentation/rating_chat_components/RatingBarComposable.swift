//
//  RatingBarComposable.swift
//  Chatbot Application
//
//  Created by badr_hourimeche on 27/8/2024.
//

import SwiftUI


struct RatingBar: View {
    @State private var rating: Int = -1
    var onRatingSelected: (Int) -> Void

    var body: some View {
        VStack {
            HStack {
                ForEach(0..<5) { index in
                    Image(systemName: index < rating ? "star.fill" : "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(index < rating ? Color(hex: 0xFFFFC107) : Color(hex: 0xFFD1D5DB))
                        .padding(4)
                        .onTapGesture {
                            if rating == -1 {
                                rating = index + 1
                                onRatingSelected(rating)
                            }
                        }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
