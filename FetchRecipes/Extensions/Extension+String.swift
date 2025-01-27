//
//  Extension+String.swift
//  FetchRecipes
//
//  Created by Cornelius Coachman on 1/27/25.
//

import Foundation

extension String {
    func getRecipeURLString(urlType: Recipe.RecipeURLStringType) -> String {
        switch urlType {
        case .success:
            return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        case .malformed:
            return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        case .empty:
            return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        }
    }
}

