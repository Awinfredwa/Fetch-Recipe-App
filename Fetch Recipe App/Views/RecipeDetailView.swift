//
//  RecipeDetailView.swift
//  Fetch Recipe App
//
//  Created by Winfred Wang on 4/6/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let url = recipe.photoURLLarge ?? recipe.photoURLSmall {
                    ImageView(url: url)
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.bottom)
                }

                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if let sourceURL = recipe.sourceURL {
                    Link("View Full Recipe", destination: sourceURL)
                        .font(.headline)
                        .padding(.top)
                }

                if let youtubeURL = recipe.youtubeURL {
                    Link("Watch on YouTube", destination: youtubeURL)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

