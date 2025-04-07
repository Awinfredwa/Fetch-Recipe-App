//
//  RecipeServiceTests.swift
//  Fetch Recipe AppTests
//
//  Created by Winfred Wang on 4/6/25.
//

import XCTest
@testable import Fetch_Recipe_App

final class RecipeServiceTests: XCTestCase {

    func testFetchValidRecipes() async throws {
        let service = RecipeService()
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

        let recipes = try await service.getRecipes(from: url)

        XCTAssertFalse(recipes.isEmpty, "Recipes should not be empty")
        XCTAssertNotNil(recipes.first?.name)
        XCTAssertNotNil(recipes.first?.id)
        XCTAssertNotNil(recipes.first?.cuisine)
    }

    func testFetchMalformedRecipesThrowsError() async {
        let service = RecipeService()
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!

        do {
            _ = try await service.getRecipes(from: url)
            XCTFail("Expected error on malformed JSON")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }

    func testFetchEmptyRecipesReturnsEmptyList() async throws {
        let service = RecipeService()
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!

        let recipes = try await service.getRecipes(from: url)

        XCTAssertTrue(recipes.isEmpty, "Expected empty recipe list")
    }
}
