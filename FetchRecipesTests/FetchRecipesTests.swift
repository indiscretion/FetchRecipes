//
//  FetchRecipesTests.swift
//  FetchRecipesTests
//
//  Created by Cornelius Coachman on 1/27/25.
//

import Testing
@testable import FetchRecipes
import Foundation
import SwiftData

struct FetchRecipesTests {
    
    let decoder = JSONDecoder()
    let testData: Data = """
    {
        "recipes": [
            {
                "cuisine": "British",
                "name": "Bakewell Tart",
                "photo_url_large": "https://some.url/large.jpg",
                "photo_url_small": "https://some.url/small.jpg",
                "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                "source_url": "https://some.url/index.html",
                "youtube_url": "https://www.youtube.com/watch?v=some.id"
            }
        ]
      }
    """.data(using: .utf8)!
    
    // MARK: Recipes
    @Test func testRecipesValidJSON() throws {
        let recipes = try decoder.decode(Recipes.self, from: testData)

        #expect(recipes != nil)
    }
    
    // MARK: Recipes
    @Test func testRecipesDataValidValues() throws {
        let recipeContainer = try decoder.decode(Recipes.self, from: testData)

        for recipe in recipeContainer.recipes {
            #expect(recipe.cuisine == "British")
            #expect(recipe.name == "Bakewell Tart")
            #expect(recipe.photo_url_large == "https://some.url/large.jpg")
            #expect(recipe.photo_url_small == "https://some.url/small.jpg")
            #expect(recipe.source_url == "https://some.url/index.html")
            #expect(recipe.youtube_url == "https://www.youtube.com/watch?v=some.id")
        }
    }
    
    @Test func testRecipesDataInvalidValues() throws {
        let recipeContainer = try decoder.decode(Recipes.self, from: testData)

        for recipe in recipeContainer.recipes {
            #expect(recipe.cuisine != "fdasfd")
            #expect(recipe.name != "Bakefdasfs")
            #expect(recipe.photo_url_large != "httpasfd")
            #expect(recipe.photo_url_small != "ht222/small.jpg")
            #expect(recipe.source_url != "https://somesl")
            #expect(recipe.youtube_url != "https://fdfs.youtube.com/watch?v=some.id")
        }
    }
    
    @Test func testRecipesDataValidTypes() throws {
        let recipeContainer = try decoder.decode(Recipes.self, from: testData)

        for recipe in recipeContainer.recipes {
            #expect(recipe.cuisine as Any is String)
            #expect(recipe.name as Any is String)
            #expect(recipe.photo_url_large as Any is String)
            #expect(recipe.photo_url_small as Any is String)
            #expect(recipe.source_url as Any is String)
            #expect(recipe.youtube_url as Any is String)
        }
    }
    
    @Test func testRecipesDataInvalidTypes() throws {
        let recipeContainer = try decoder.decode(Recipes.self, from: testData)

        for recipe in recipeContainer.recipes {
            #expect(!(recipe.cuisine as Any is Int))
            #expect(!(recipe.name as Any is Bool))
            #expect(!(recipe.photo_url_large as Any is Double))
            #expect(!(recipe.photo_url_small as Any is Int))
            #expect(!(recipe.source_url as Any is Int32))
            #expect(!(recipe.youtube_url as Any is Double))
        }
    }

    @Test func testExtensionValidURLStrings() async throws {
        let emptyURLString = String().getRecipeURLString(urlType: .empty)
        let malformedURLString = String().getRecipeURLString(urlType: .malformed)
        let successURLString = String().getRecipeURLString(urlType: .success)
        
        #expect(emptyURLString == "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
        #expect(malformedURLString == "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        #expect(successURLString == "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
    }
    
    @Test func testExtensionInvalidURLStrings() async throws {
        let emptyURLString = String().getRecipeURLString(urlType: .empty)
        let malformedURLString = String().getRecipeURLString(urlType: .malformed)
        let successURLString = String().getRecipeURLString(urlType: .success)
        
        #expect(emptyURLString != "https://232r3qrwqwerq23erqew.cloudfront.net/recipes-empty")
        #expect(malformedURLString != "https://d3jbb8n5wk0qxi.cloudfront.net/∫-malfsafsdf")
        #expect(successURLString != "https://d3jbb8n5wk0qxi.cloudfront.net/rfsadfn")
    }
}
