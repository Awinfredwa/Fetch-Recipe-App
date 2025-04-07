//
//  RecipeCard.swift
//  Fetch Recipe App
//
//  Created by Winfred Wang on 4/6/25.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let url = recipe.photoURLSmall {
                ImageView(url: url)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(12)
            } else {
                Color.gray
                    .frame(height: 150)
                    .cornerRadius(12)
            }

            Text(recipe.name)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.primary)

            Text(recipe.cuisine)
                .font(.subheadline)
                .foregroundStyle(.secondary)
              
        }
        .buttonBorderShape(.roundedRectangle(radius: 8))
        .padding(8)
        .background(Color(.systemBackground))
        //.cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        // For visionOS UI
        
    }
}
