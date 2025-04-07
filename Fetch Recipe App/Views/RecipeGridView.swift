//
//  RecipeGridView.swift
//  Fetch Recipe App
//
//  Created by Winfred Wang on 4/6/25.
//

import SwiftUI

struct RecipeGridView: View {
    @StateObject private var viewModel = RecipeViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.recipes.isEmpty {
                    Text("No recipes available.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(viewModel.recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCard(recipe: recipe)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Recipes")
            .refreshable {
                await viewModel.loadRecipes()
            }
        }
        .task {
            await viewModel.loadRecipes()
        }
    }
}


#Preview {
    RecipeGridView()
}
