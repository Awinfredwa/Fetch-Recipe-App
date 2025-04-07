//
//  RecipeViewModel.swift
//  Fetch Recipe App
//
//  Created by Winfred Wang on 4/6/25.
//

import Foundation

@MainActor
final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var error: String?
    
    private let service = RecipeService()

    func loadRecipes() async {
        do {
            let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
            self.recipes = try await service.getRecipes(from: url)
            self.error = nil
        } catch {
            self.error = "Failed to load recipes."
            self.recipes = []
        }
    }
}
