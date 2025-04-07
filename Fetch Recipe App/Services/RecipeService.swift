//
//  RecipeService.swift
//  Fetch Recipe App
//
//  Created by Winfred Wang on 4/6/25.
//

import Foundation

// For network operations related to recipe

final class RecipeService {
    //Fetch all recipes
    func getRecipes(from url: URL) async throws -> [Recipe] {
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return decoded.recipes
        } catch {
            throw URLError(.cannotParseResponse)
        }
    }
}
